cd ~/programming/cp
git add .
echo "enter commit message: "
read msg
git commit -m $msg
echo "successfully committed changed"
python3 build_readme.py
echo "successfully updated readme"
git push origin main
echo "successfully pushed to origin"