#include <iostream>
#include <fstream>
#include <vector>
#include "eigen3/Eigen/Dense"
#include "eigen3/Eigen/Geometry"
#include <boost/array.hpp>
using namespace std;
using Eigen::MatrixXd;
using Eigen::VectorXd;
double RAD(double deg) { return deg*M_PI / 180.0; }

Eigen::Affine3d create_rotation_matrix(double ax, double ay, double az) {
    Eigen::Affine3d rx =
        Eigen::Affine3d(Eigen::AngleAxisd(RAD(ax), Eigen::Vector3d(1, 0, 0)));
    Eigen::Affine3d ry =
        Eigen::Affine3d(Eigen::AngleAxisd(RAD(ay), Eigen::Vector3d(0, 1, 0)));
    Eigen::Affine3d rz =
        Eigen::Affine3d(Eigen::AngleAxisd(RAD(az), Eigen::Vector3d(0, 0, 1)));
    return rz * ry * rx;
}
int main() {
    boost::array<double, 36> ar;
    for(int i=0; i<ar.size(); ++i){
        ar[i] =i*10;
        }
    cout<<ar.size()<<endl;
    const double* p=ar.c_array();
    Eigen::Affine3d r = create_rotation_matrix(45, 0, 0);
    Eigen::Affine3d t(Eigen::Translation3d(Eigen::Vector3d(1, 16, -26)));
    Eigen::Affine3d H = (t * r);
    Eigen::Matrix4d m = H.matrix(); // Option 1
    cout << m << endl;
    cout << m.block(1,1,3,3)<< endl;
    cout << "Rotation of H" << endl;
    Eigen::MatrixXd R = H.rotation();
    Eigen::MatrixXd ssz(2,2);
    ssz<<1,2,4,7;
    cout << ssz(1,1) << endl;
    cout << R << endl;
    cout << "Translation of H" << endl;
    Eigen::VectorXd T = H.translation();
    Eigen::VectorXd T1 = Eigen::Vector3d(0,0,5);
    Eigen::VectorXd T2 = T+T1;
    cout << T << endl;
    cout << T2 << endl;
    Eigen::VectorXd s(4);
    s[0]=1;
    s[1]=2;
    s[2]=3;
    s[3]=4;
    Eigen::MatrixXd qwe=Eigen::Map<Eigen::MatrixXd>(s.data(),2,2).transpose();
    cout<<qwe<<endl;
}



