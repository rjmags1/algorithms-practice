cd ~/programming/projects/cp
python3 build_readme.py
echo "successfully updated readme"
git add .
echo "enter commit message: "
read msg
git commit -m $msg
echo "successfully committed changed"
git push origin main
echo "successfully pushed to origin"