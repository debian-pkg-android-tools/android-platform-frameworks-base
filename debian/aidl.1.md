% AIDL(1) Build-tools 23.0.1  | aidl Manual
% The Android Open Source Project
% 8 October 2015

# NAME

aidl - Android Interface Defenition Language processor

# SYNOPSIS

**aidl** _OPTIONS_ _INPUT_ [_OUTPUT_]

**aidl** --preprocess _OUTPUT_ _INPUT..._

# OPTIONS

-I\<DIR\>
: Search path for import statements.

-d\<FILE\>
: Generate dependency file.

-a
: Generate dependency file next to the output file with the name based on the
  input file.

-p\<FILE\>
: File created by **--preprocess** to import.

-o\<FOLDER\>
: Base output folder for generated files.

-b
: Fail when trying to compile a parcelable.

INPUT
: An aidl interface file.

OUTPUT
: The generated interface files.

If **OUTPUT** is omitted and the **-o** option is not used, the input filename
is used, with the **.aidl** extension changed to a **.java** extension.

If the **-o** option is used, the generated files will be placed in the base
output folder under their package folder.

# SEE ALSO

https://developer.android.com/guide/components/aidl.html