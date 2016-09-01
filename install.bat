@echo off
if %COMPUTERNAME%==AITHER (
echo install for work
python dotbot\bin\dotbot -d .\ -c install.conf_win_work.yaml
) else (
install for home
python dotbot\bin\dotbot -d .\ -c install.conf_win.yaml
)
