set godot_path="C:\Program Files\Godot_v4.2.2\Godot_v4.2.2-stable_win64.exe"
set project_path=E:\private\projects\Godot\dlc_test\godot
set export_path=E:\private\projects\Godot\dlc_test\builds\
set export_path_file=dlc_test.exe

set export_path_dlc=dlcs\
set dlc_filetype=.zip
set dlc_name_00=dlc_default
set dlc_name_01=dlc_corgi
set dlc_name_02=dlc_kitty
set dlc_name_03=dlc_sheepy

mkdir "%export_path%"
mkdir "%export_path%%export_path_dlc%"

%godot_path% --headless --path %project_path% --export-release windows %export_path%%export_path_file%
%godot_path% --headless --path %project_path% --export-pack %dlc_name_00% %export_path%%export_path_dlc%%dlc_name_00%%dlc_filetype%
%godot_path% --headless --path %project_path% --export-pack %dlc_name_01% %export_path%%export_path_dlc%%dlc_name_01%%dlc_filetype%
%godot_path% --headless --path %project_path% --export-pack %dlc_name_02% %export_path%%export_path_dlc%%dlc_name_02%%dlc_filetype%
%godot_path% --headless --path %project_path% --export-pack %dlc_name_03% %export_path%%export_path_dlc%%dlc_name_03%%dlc_filetype%