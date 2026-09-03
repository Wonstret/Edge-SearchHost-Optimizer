if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Elevando privilegios para Administrador..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm $($MyInvocation.MyCommand.Definition) | iex`"" -Verb RunAs -ErrorAction SilentlyContinue
    exit
}

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

$lang = @{
    "EN" = @{
        "Title" = "Edge & SearchHost Optimizer";
        "Badge" = "[VIBE CODED SCRIPT]";
        "Subtitle" = "Remove Microsoft Edge, block reinstallations and hide taskbar search icon.";
        "OptHeader" = "Select actions to perform:";
        "ChkUninstall" = "Uninstall Microsoft Edge (Browser)";
        "ChkBlock" = "Block Reinstallation via Windows Update & Policies";
        "ChkBing" = "Disable Web Search & Hide Search Icon (Leaves only Windows button)";
        "ChkClean" = "Remove residual shortcuts from Desktop and Start Menu";
        "BtnRun" = "Execute Optimization";
        "BtnRestore" = "Restore Defaults";
        "Ready" = "Ready. Select actions and click 'Execute Optimization'...";
        "Closing" = "Closing active Edge and search processes...";
        "Uninstalling" = "Searching for Microsoft Edge installer...";
        "Uninstalled" = "Microsoft Edge uninstalled successfully!";
        "NotFound" = "Edge installer not found or already removed.";
        "Blocking" = "Applying Edge reinstallation block policies...";
        "Blocked" = "Edge reinstallation blocked in Registry & Services.";
        "DisablingBing" = "Disabling Web Search and hiding Taskbar Search icon...";
        "BingDisabled" = "Search icon hidden and web search disabled!";
        "Cleaning" = "Cleaning residual shortcuts...";
        "RestartingExplorer" = "Restarting Windows Explorer...";
        "Done" = "Completed successfully! Taskbar and system optimized.";
        "Restoring" = "Restoring settings and services to Windows defaults...";
        "Restored" = "Settings restored to Windows defaults.";
        "Credits" = "Credits: AveYo (Edge-Removal-Tool) | ChrisTitusTech (WinUtil) | Catppuccin Palette"
    };
    "PT" = @{
        "Title" = "Edge & SearchHost Optimizer";
        "Badge" = "[SCRIPT VIBE CODADO]";
        "Subtitle" = "Remova o Edge, bloqueie reinstalações e oculte a lupa da barra de tarefas.";
        "OptHeader" = "Selecione as ações que deseja realizar:";
        "ChkUninstall" = "Desinstalar Microsoft Edge (Navegador)";
        "ChkBlock" = "Bloquear Reinstalação pelo Windows Update (Políticas e Serviços)";
        "ChkBing" = "Desativar Busca Web e Ocultar Lupa (Deixar apenas o botão Windows)";
        "ChkClean" = "Remover atalhos residuais da Área de Trabalho e Menu Iniciar";
        "BtnRun" = "Executar Otimização";
        "BtnRestore" = "Reverter Tudo";
        "Ready" = "Pronto para iniciar. Selecione as opções e clique em 'Executar Otimização'...";
        "Closing" = "Fechando processos ativos do Edge e Pesquisa...";
        "Uninstalling" = "Procurando instalador nativo do Microsoft Edge...";
        "Uninstalled" = "Microsoft Edge desinstalado com sucesso!";
        "NotFound" = "Instalação do Edge não encontrada ou já removida.";
        "Blocking" = "Aplicando políticas de bloqueio de reinstalação...";
        "Blocked" = "Reinstalação do Edge bloqueada no Registro e Serviços.";
        "DisablingBing" = "Desativando busca Web e ocultando o ícone de lupa da barra de tarefas...";
        "BingDisabled" = "Lupa ocultada e busca Web desativada!";
        "Cleaning" = "Limpando atalhos residuais...";
        "RestartingExplorer" = "Reiniciando Windows Explorer...";
        "Done" = "Concluído com sucesso! Barra de tarefas e sistema otimizados.";
        "Restoring" = "Restaurando configurações e serviços para o padrão...";
        "Restored" = "Configurações restauradas para o padrão do Windows.";
        "Credits" = "Créditos: AveYo (Edge-Removal-Tool) | ChrisTitusTech (WinUtil) | Catppuccin Palette"
    }
}

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Edge &amp; SearchHost Optimizer" Height="620" Width="680"
        WindowStartupLocation="CenterScreen" Background="#181825"
        ResizeMode="CanMinimize" FontFamily="Segoe UI">
    <Window.Resources>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#CDD6F4"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Margin" Value="0,6,0,6"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
        <Style TargetType="Button">
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Height" Value="38"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="6" BorderThickness="0">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <Grid Grid.Row="0" Margin="0,0,0,15">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>

            <StackPanel Grid.Column="0">
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="lblTitle" Text="Edge &amp; SearchHost Optimizer" FontSize="20" FontWeight="Bold" Foreground="#89B4FA"/>
                    <Border Background="#313244" CornerRadius="4" Padding="6,2" Margin="10,0,0,0" VerticalAlignment="Center">
                        <TextBlock Name="lblBadge" Text="[VIBE CODED SCRIPT]" FontSize="10" FontWeight="Bold" Foreground="#F38BA8"/>
                    </Border>
                </StackPanel>
                <TextBlock Name="lblSubtitle" Text="Remove Microsoft Edge, block reinstallations and hide taskbar search icon." FontSize="12" Foreground="#A6ADC8" Margin="0,4,0,0"/>
            </StackPanel>

            <ComboBox Name="cmbLang" Grid.Column="1" VerticalAlignment="Center" Width="110" Height="28" Background="#313244" Foreground="#CDD6F4" BorderThickness="0">
                <ComboBoxItem Content="English" IsSelected="True"/>
                <ComboBoxItem Content="Português"/>
            </ComboBox>
        </Grid>

        <Border Grid.Row="1" Background="#1E1E2E" CornerRadius="8" Padding="15" Margin="0,0,0,15">
            <StackPanel>
                <TextBlock Name="lblOptHeader" Text="Select actions to perform:" FontSize="13" FontWeight="Bold" Foreground="#CBA6F7" Margin="0,0,0,8"/>
                <CheckBox Name="chkUninstallEdge" Content="Uninstall Microsoft Edge (Browser)" IsChecked="True"/>
                <CheckBox Name="chkBlockUpdate" Content="Block Reinstallation via Windows Update &amp; Policies" IsChecked="True"/>
                <CheckBox Name="chkDisableBing" Content="Disable Web Search &amp; Hide Search Icon (Leaves only Windows button)" IsChecked="True"/>
                <CheckBox Name="chkCleanShortcuts" Content="Remove residual shortcuts from Desktop and Start Menu" IsChecked="True"/>
            </StackPanel>
        </Border>

        <Border Grid.Row="2" Background="#11111B" CornerRadius="8" Padding="10" Margin="0,0,0,15">
            <ScrollViewer Name="scrollLog" VerticalScrollBarVisibility="Auto">
                <TextBox Name="txtLog" Background="Transparent" Foreground="#A6E3A1" BorderThickness="0"
                         FontFamily="Consolas" FontSize="11" IsReadOnly="True" TextWrapping="Wrap"/>
            </ScrollViewer>
        </Border>

        <Grid Grid.Row="3" Margin="0,0,0,10">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="2*"/>
                <ColumnDefinition Width="10"/>
                <ColumnDefinition Width="1*"/>
            </Grid.ColumnDefinitions>

            <Button Name="btnExecute" Grid.Column="0" Content="Execute Optimization" Background="#89B4FA" Foreground="#11111B"/>
            <Button Name="btnRestore" Grid.Column="2" Content="Restore Defaults" Background="#313244" Foreground="#CDD6F4"/>
        </Grid>

        <TextBlock Name="lblCredits" Grid.Row="4" Text="Credits: AveYo (Edge-Removal-Tool) | ChrisTitusTech (WinUtil) | Catppuccin Palette"
                   FontSize="10" Foreground="#585B70" HorizontalAlignment="Center"/>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$lblTitle          = $window.FindName("lblTitle")
$lblBadge          = $window.FindName("lblBadge")
$lblSubtitle       = $window.FindName("lblSubtitle")
$lblOptHeader      = $window.FindName("lblOptHeader")
$chkUninstallEdge  = $window.FindName("chkUninstallEdge")
$chkBlockUpdate    = $window.FindName("chkBlockUpdate")
$chkDisableBing    = $window.FindName("chkDisableBing")
$chkCleanShortcuts = $window.FindName("chkCleanShortcuts")
$txtLog            = $window.FindName("txtLog")
$scrollLog         = $window.FindName("scrollLog")
$btnExecute        = $window.FindName("btnExecute")
$btnRestore        = $window.FindName("btnRestore")
$lblCredits        = $window.FindName("lblCredits")
$cmbLang           = $window.FindName("cmbLang")

$currentLang = "EN"

function UpdateLanguage($l) {
    $script:currentLang = $l
    $dict = $lang[$l]
    $lblTitle.Text = $dict["Title"]
    $lblBadge.Text = $dict["Badge"]
    $lblSubtitle.Text = $dict["Subtitle"]
    $lblOptHeader.Text = $dict["OptHeader"]
    $chkUninstallEdge.Content = $dict["ChkUninstall"]
    $chkBlockUpdate.Content = $dict["ChkBlock"]
    $chkDisableBing.Content = $dict["ChkBing"]
    $chkCleanShortcuts.Content = $dict["ChkClean"]
    $btnExecute.Content = $dict["BtnRun"]
    $btnRestore.Content = $dict["BtnRestore"]
    $lblCredits.Text = $dict["Credits"]
    if ([string]::IsNullOrWhiteSpace($txtLog.Text)) {
        $txtLog.Text = $dict["Ready"] + "`n"
    }
}

$cmbLang.Add_SelectionChanged({
    if ($cmbLang.SelectedIndex -eq 1) {
        UpdateLanguage "PT"
    } else {
        UpdateLanguage "EN"
    }
})

function Log($msg) {
    $time = (Get-Date).ToString("HH:mm:ss")
    $txtLog.AppendText("[$time] $msg`n")
    $scrollLog.ScrollToEnd()
    [System.Windows.Forms.Application]::DoEvents()
}

$btnExecute.Add_Click({
    $btnExecute.IsEnabled = $false
    $btnRestore.IsEnabled = $false
    $txtLog.Text = ""
    $d = $lang[$script:currentLang]
    
    Log $d["Closing"]
    @("msedge", "MicrosoftEdgeUpdate", "SearchHost") | ForEach-Object {
        Get-Process -Name $_ -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    }

    if ($chkUninstallEdge.IsChecked) {
        Log $d["Uninstalling"]
        $edgePaths = @(
            "${env:ProgramFiles(x86)}\Microsoft\Edge\Application",
            "${env:ProgramFiles}\Microsoft\Edge\Application"
        )
        $found = $false
        foreach ($path in $edgePaths) {
            if (Test-Path $path) {
                $installer = Get-ChildItem -Path $path -Filter "setup.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($installer) {
                    Start-Process -FilePath $installer.FullName -ArgumentList "--uninstall --system-level --verbose-logging --force-uninstall" -Wait
                    $found = $true
                }
            }
        }
        Get-AppxPackage -AllUsers *MicrosoftEdge* -ErrorAction SilentlyContinue | Where-Object { 
            $_.Name -notlike "*DevToolsClient*" -and $_.Name -notlike "*SystemApps*" -and -not $_.NonRemovable 
        } | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        
        if ($found) { Log $d["Uninstalled"] } else { Log $d["NotFound"] }
    }

    if ($chkBlockUpdate.IsChecked) {
        Log $d["Blocking"]
        $regPath = "HKLM:\SOFTWARE\Microsoft\EdgeUpdate"
        if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
        Set-ItemProperty -Path $regPath -Name "DoNotUpdateToEdgeWithChromium" -Value 1 -Type DWord -Force

        @("edgeupdate", "edgeupdatem") | ForEach-Object {
            if (Get-Service -Name $_ -ErrorAction SilentlyContinue) {
                Stop-Service -Name $_ -Force -ErrorAction SilentlyContinue
                Set-Service -Name $_ -StartupType Disabled -ErrorAction SilentlyContinue
            }
        }
        @("MicrosoftEdgeUpdateTaskMachineCore", "MicrosoftEdgeUpdateTaskMachineUA") | ForEach-Object {
            Get-ScheduledTask -TaskName $_ -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null
        }
        Log $d["Blocked"]
    }

    if ($chkDisableBing.IsChecked) {
        Log $d["DisablingBing"]
        $explorerPolicy = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
        if (-not (Test-Path $explorerPolicy)) { New-Item -Path $explorerPolicy -Force | Out-Null }
        Set-ItemProperty -Path $explorerPolicy -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord -Force

        $searchReg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
        if (-not (Test-Path $searchReg)) { New-Item -Path $searchReg -Force | Out-Null }
        Set-ItemProperty -Path $searchReg -Name "SearchboxTaskbarMode" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $searchReg -Name "BingSearchEnabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $searchReg -Name "CortanaConsent" -Value 0 -Type DWord -Force
        Log $d["BingDisabled"]
    }

    if ($chkCleanShortcuts.IsChecked) {
        Log $d["Cleaning"]
        @(
            "$env:Public\Desktop\Microsoft Edge.lnk",
            "$env:USERPROFILE\Desktop\Microsoft Edge.lnk",
            "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk",
            "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
        ) | ForEach-Object {
            if (Test-Path $_) { Remove-Item -Path $_ -Force -ErrorAction SilentlyContinue }
        }
    }

    Log $d["RestartingExplorer"]
    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) { Start-Process explorer.exe }

    Log $d["Done"]
    $btnExecute.IsEnabled = $true
    $btnRestore.IsEnabled = $true
})

$btnRestore.Add_Click({
    $btnExecute.IsEnabled = $false
    $btnRestore.IsEnabled = $false
    $txtLog.Text = ""
    $d = $lang[$script:currentLang]
    
    Log $d["Restoring"]

    $regPath = "HKLM:\SOFTWARE\Microsoft\EdgeUpdate"
    if (Test-Path $regPath) {
        Remove-ItemProperty -Path $regPath -Name "DoNotUpdateToEdgeWithChromium" -ErrorAction SilentlyContinue
    }

    @("edgeupdate", "edgeupdatem") | ForEach-Object {
        if (Get-Service -Name $_ -ErrorAction SilentlyContinue) {
            Set-Service -Name $_ -StartupType Automatic -ErrorAction SilentlyContinue
            Start-Service -Name $_ -ErrorAction SilentlyContinue
        }
    }

    @("MicrosoftEdgeUpdateTaskMachineCore", "MicrosoftEdgeUpdateTaskMachineUA") | ForEach-Object {
        Get-ScheduledTask -TaskName $_ -ErrorAction SilentlyContinue | Enable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null
    }

    $searchReg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
    if (Test-Path $searchReg) {
        Set-ItemProperty -Path $searchReg -Name "SearchboxTaskbarMode" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $searchReg -Name "BingSearchEnabled" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path $searchReg -Name "CortanaConsent" -Value 1 -Type DWord -Force
    }
    $explorerPolicy = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
    if (Test-Path $explorerPolicy) {
        Remove-ItemProperty -Path $explorerPolicy -Name "DisableSearchBoxSuggestions" -ErrorAction SilentlyContinue
    }

    Log $d["RestartingExplorer"]
    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) { Start-Process explorer.exe }

    Log $d["Restored"]
    $btnExecute.IsEnabled = $true
    $btnRestore.IsEnabled = $true
})

UpdateLanguage "EN"
$window.ShowDialog() | Out-Null
