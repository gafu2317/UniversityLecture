#!/bin/sh
# Debug version

for image in $1/final/*.ppm; do
    bname=$(basename "$image")
    name="imgproc/$bname"
    echo "Processing: $name"

    case $1 in
        *level1*) magick "$image" "$name"; threshold=0.5 ;;
        *) magick "$image" "$name"; threshold=0.5 ;;
    esac

    echo "$bname:"
    result_file="result/${bname%.*}.txt"
    > "$result_file"

    best_distance=999999
    best_result=""

    for template in $1/*.ppm; do
        template_name=$(basename "$template" .ppm)
        echo "Template: $template_name"

        angle=0
        echo "  Testing angle: $angle"
        rotated_template="temp_${angle}_${template_name}.ppm"

        echo "DEBUG: Creating rotated template: $rotated_template"
        if magick "$template" -background black -rotate "$angle" -blur 0x1 "$rotated_template" 2>/dev/null; then
            echo "DEBUG: Template created successfully"
            echo "DEBUG: Calling: ./matching $name $rotated_template $angle $threshold p"
            
            output=$(./matching "$name" "$rotated_template" "$angle" "$threshold" p)
            echo "DEBUG: Output received: '$output'"

            if echo "$output" | grep -q "\[Found"; then
                echo "DEBUG: Found match!"
                found_line=$(echo "$output" | grep "\[Found" | head -n 1)
                echo "DEBUG: Found line: $found_line"

                res_x=$(echo "$found_line" | awk '{print $4}')
                res_y=$(echo "$found_line" | awk '{print $5}')
                res_w=$(echo "$found_line" | awk '{print $6}')
                res_h=$(echo "$found_line" | awk '{print $7}')
                distance=$(echo "$found_line" | awk '{print $9}')

                echo "DEBUG: Parsed values: x=$res_x y=$res_y w=$res_w h=$res_h dist=$distance"

                if awk "BEGIN {exit !($distance < $best_distance)}"; then
                    best_distance=$distance
                    best_result="$template_name $res_x $res_y $res_w $res_h $angle"
                    echo "DEBUG: New best result: $best_result"
                fi
            else
                echo "DEBUG: No [Found] in output"
            fi
        else
            echo "DEBUG: Failed to create template"
        fi

        rm -f "$rotated_template"
    done

    if [ ! -z "$best_result" ]; then
        echo "DEBUG: Writing result: $best_result"
        echo "$best_result" > "$result_file"
    else
        echo "DEBUG: No result found"
    fi

    # 最初の1つだけテストして終了
    break
done
