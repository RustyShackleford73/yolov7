#!/bin/bash
# COCO 2017 dataset http://cocodataset.org
# Download command: bash data/scripts/get_coco.sh
# Train command: python train.py --data coco.yaml
# Default dataset location is next to YOLOv5:
#   /parent_folder
#     /coco
#     /yolov5

# Download weights
d='weights/'
url=https://github.com/WongKinYiu/yolov7/releases/download/v0.1/
w1='yolov7-w6-person.pt'
w2='yolov7-w6-pose.pt'
w3='yolov7.pt'
for w in $w1 $w2 $w3; do
  echo 'Downloading' $w '...'
  curl -L $url$w -o $d$w
done

# Download/unzip labels
d='../' # unzip directory
url=https://github.com/WongKinYiu/yolov7/releases/download/v0.1/
f='coco2017labels-keypoints.zip'
echo 'Downloading' $url$f ' ...'
curl -L $url$f -o $f && unzip -q $f -d $d && rm $f & # download, unzip, remove in background

# Download/unzip images
d='../coco/images' # unzip directory
url=http://images.cocodataset.org/zips/
f1='train2017.zip' # 19G, 118k images
f2='val2017.zip'   # 1G, 5k images
f3='test2017.zip'  # 7G, 41k images (optional)
for f in $f1 $f2; do
  echo 'Downloading' $url$f '...'
  curl -L $url$f -o $f && unzip -q $f -d $d && rm $f & # download, unzip, remove in background
done
wait # finish background tasks

