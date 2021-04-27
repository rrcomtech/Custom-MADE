#!/bin/bash

# Is meant to the following things:
# 	1. Build Language Server.
#	  2. Unzip Language Server to get binaries.
#	      Result:
#		      - /bin/ --> The Language Server binaries
#		      - /lib/ --> The required jars.
#			      (not seem to be needed for execution of the binaries..).
# 	3. Copy binaries to /dedoc-editor/mdr-dsl/build/mdr-language/.
#	  4. Rename binaries to MDR-LanguageServer.bat / MDR-LanguageServer.
#	     (this is required by Theia
# 	    -> change by looking at /mdr-dsl/src/node/mdr-dsl-language-server-contribution.ts)
#	  5. If Frontend is to be recompiled --> specify "-rc" --> script executes in /dedoc-editor/ "yarn"
# 	6. In /dedoc-editor/browser-app --> "yarn start ./workspace/"

#language_server_path="/home/robert/programming/XtextMDR_Forked/"
language_server_path="/home/robert/programming/GitLab-XtextLS-Richter"
distribution_path="org.xtext.example.mydsl.ide/build/distributions/"
custom_made_path="/home/robert/programming/CustomMADE/"
snapshot_name="org.xtext.example.mydsl.ide-1.0.0-SNAPSHOT"

# Step 1
cd "$language_server_path" || exit 1
./gradlew clean build

# Step 2
cd "$distribution_path" || exit 1
# rm -R "$snapshot_name"
unzip -o -q "$snapshot_name.zip"

# Step 3
cp -R "./$snapshot_name" "$custom_made_path/dedoc-editor/mdr-dsl/build/"
cd "$custom_made_path/dedoc-editor/mdr-dsl/build/" || exit 1

# Step 4
rm -R "mdr-language"
mv "./$snapshot_name" "./mdr-language"

# Step 5
cd "../../"
if [[ $1 == "-rc" ]]
then
  yarn
fi

# Step 6
cd "browser-app" || exit 1
yarn start ./workspace/
