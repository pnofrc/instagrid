x=0; for i in *.wav; do echo $x; ffmpeg -i "$i" -ss 0 -t 30 $x.mp3; let x=x+1; done

magick cover.png -resize 33% cover.jpg

magick cover.png -crop 3x3@ +repage +adjoin %d.jpg

START=0
END=${x}

if [ $END -eq 9 ]; then 

    mkdir 0;
    mkdir 1;
    mkdir 2;
    mkdir 3;
    mkdir 4;
    mkdir 5;
    mkdir 6;
    mkdir 7;
    mkdir 8;

elif [ $END -eq 8 ]; then

    mkdir 0;
    mkdir 1;
    mkdir 2;
    mkdir 3;
    mkdir 5;
    mkdir 6;
    mkdir 7;
    mkdir 8;


elif [ $END -eq 7 ]; then

    mkdir 0;
    mkdir 1;
    mkdir 2;
    mkdir 4;
    mkdir 6;
    mkdir 7;
    mkdir 8;


elif [ $END -eq 6 ]; then

    mkdir 0;
    mkdir 2;
    mkdir 3;
    mkdir 5;
    mkdir 6;
    mkdir 8;


elif [ $END -eq 5 ]; then

    mkdir 0;
    mkdir 2;
    mkdir 4;
    mkdir 7;
    mkdir 8;

   

elif [ $END -eq 4 ]; then

    mkdir 1;
    mkdir 3;
    mkdir 5;
    mkdir 7;
    
fi




x=0; for folder in */ 
do
echo $x
    mv $x.mp3 ./${folder}0.mp3
    mv $(basename "$folder").jpg ./${folder}0.jpg

    let x=x+1
done


 
for folder in */
    do 
    for i in {6..375} 
        do 
        cp cover.jpg $folder/$i.jpg 
    done
    for y in {1..5} 
        do 
        cp ${folder}0.jpg ${folder}$y.jpg 
    done
done


for folder in */
    do 
        cd $folder
        ffmpeg -r 25 -i %d.jpg -i 0.mp3 -c:v libx264 -vf fps=12 -pix_fmt yuv420p $(basename "$folder").mp4
        cd .. 
    done

for folder in */
    do 
        cd $folder;
        rm 0.mp3 
        for i in {0..375}
            do 
            rm $i.jpg
    done
    mv $(basename "$folder").mp4 ../
    cd ..
    rmdir $folder
done
