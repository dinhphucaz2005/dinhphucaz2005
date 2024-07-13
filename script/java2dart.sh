#!/usr/bin/env bash
set -e

if [ $# -lt 1 ]; then
  echo "Usage: $0 <input_file.java or .kt>"
  exit 1
fi

inputFile="$1"
outputFile="$inputFile"

# Đổi đuôi thành .dart
if [[ "$outputFile" == *.java ]]; then
  outputFile="${outputFile%.java}.dart"
elif [[ "$outputFile" == *.kt ]]; then
  outputFile="${outputFile%.kt}.dart"
fi

# Lấy tên file
fileName="${outputFile##*/}"

# Convert CamelCase -> snake_case
newName=""
for (( i=0; i<${#fileName}; i++ )); do
  c="${fileName:$i:1}"
  if [[ "$c" =~ [A-Z] ]]; then
    if [ $i -ne 0 ]; then
      newName+="_"
    fi
    newName+="${c,,}"
  else
    newName+="$c"
  fi
done

# Lấy thư mục
directory="."
if [[ "$outputFile" == */* ]]; then
  directory="${outputFile%/*}"
fi

outputFile="$directory/$newName"

# Di chuyển file
mv "$inputFile" "$outputFile"
