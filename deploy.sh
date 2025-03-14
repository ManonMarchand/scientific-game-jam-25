declare -a dest_arr=("linux" "windows" "web")
build_dir="monkey/.build"
zip_name="parmi-les-singes"
itchio_repo="julien-paulet/parmi-les-singes"

for dest in "${dest_arr[@]}"
do
	echo "Creating $dest zip"
	zip "$build_dir/$dest/$zip_name-$dest.zip" -j $build_dir/$dest/*.*
done

for dest in "${dest_arr[@]}"
do
        echo "Deploying $dest gamefile"
	butler push "$build_dir/$dest/$zip_name-$dest.zip" $itchio_repo:$dest
done

