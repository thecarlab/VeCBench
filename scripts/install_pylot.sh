#!/bin/bash
###
 # @Description: 
 # @Author: Sauron
 # @Date: 2023-11-15 20:35:38
 # @LastEditTime: 2023-11-15 21:39:22
 # @LastEditors: Sauron
### 

###############################################################################
# Get models & code bases we depend on
###############################################################################

###### Download the model weights ######
echo "[x] Downloading all model weights..."
cd $VCBENCH_HOME/dependencies/
~/.local/bin/gdown https://drive.google.com/uc?id=1rQKFDxGDFi3rBLsMrJzb7oGZvvtwgyiL
unzip models.zip ; rm models.zip

#################### Download the code bases ####################
echo "[x] Compiling the planners..."
###### Build the FrenetOptimalTrajectory Planner ######
echo "[x] Compiling the Frenet Optimal Trajectory planner..."
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/erdos-project/frenet_optimal_trajectory_planner.git
cd frenet_optimal_trajectory_planner/
bash build.sh

###### Build the RRT* Planner ######
echo "[x] Compiling the RRT* planner..."
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/erdos-project/rrt_star_planner.git
cd rrt_star_planner/
bash build.sh

###### Build the Hybrid A* Planner ######
echo "[x] Compiling the Hybrid A* planner..."
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/erdos-project/hybrid_astar_planner.git
cd hybrid_astar_planner/
bash build.sh

###### Clone the Prediction Repository #####
echo "[x] Cloning the prediction code..."
cd $VCBENCH_HOME/pylot/prediction/
git clone https://github.com/erdos-project/prediction.git

###### Get DeepSORT and SORT tracker code bases ######
echo "[x] Cloning the object tracking code..."
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/ICGog/nanonets_object_tracking.git
sudo apt-get install python3-tk
git clone https://github.com/ICGog/sort.git
###### Download the DaSiamRPN code ######
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/ICGog/DaSiamRPN.git

###### Install CenterTrack ######
echo "[x] Installing the CenterTrack object tracking code..."
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/ICGog/CenterTrack
cd CenterTrack/src/lib/model/networks/
git clone https://github.com/CharlesShang/DCNv2/
cd DCNv2
sudo apt-get install llvm-9
export LLVM_CONFIG=/usr/bin/llvm-config-9
python3 setup.py build develop user

###### Install QDTrack ######
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/mageofboy/qdtrack.git
cd $VCBENCH_HOME/dependencies/qdtrack
python3 -m pip install mmcv==1.3.10 mmdet==2.14.0
python3 -m pip install -e ./

##### Download the Lanenet code #####
echo "[x] Cloning the lanenet lane detection code..."
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/ICGog/lanenet-lane-detection.git
mv lanenet-lane-detection lanenet

###### Download the DRN segmentation code ######
echo "[x] Cloning the DRN segmentation code..."
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/ICGog/drn.git

###### Download AnyNet depth estimation code #####
echo "[x] Cloning the AnyNet depth estimation code..."
cd $VCBENCH_HOME/dependencies/
git clone https://github.com/mileyan/AnyNet.git
cd AnyNet/models/spn_t1/ ; python3 setup.py clean ; python3 setup.py build

