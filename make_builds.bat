set godot_path="C:\Program Files\Godot_v4.2.2\Godot_v4.2.2-stable_win64.exe"
set project_path=E:\private\projects\Godot\dlc_test\godot
set export_path=E:\private\projects\Godot\dlc_test\builds\
set export_path_dlc=dlcs\
set export_path_file=dlc_test.exe

set export_path_file_dlc_01=dlc_test_corgi.zip
set export_path_file_dlc_02=dlc_test_kitty.zip
set export_path_file_dlc_03=dlc_test_sheepy.zip

mkdir "%export_path%"
mkdir "%export_path%%export_path_dlc%"

%godot_path% --headless --path %project_path% --export-release windows %export_path%%export_path_file%
%godot_path% --headless --path %project_path% --export-pack dlc_01_corgi %export_path%%export_path_dlc%%export_path_file_dlc_01%
%godot_path% --headless --path %project_path% --export-pack dlc_01_kitty %export_path%%export_path_dlc%%export_path_file_dlc_02%
%godot_path% --headless --path %project_path% --export-pack dlc_01_sheepy %export_path%%export_path_dlc%%export_path_file_dlc_03%