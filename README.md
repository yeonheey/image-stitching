# Image Stitching
## 프로젝트 개요
opencv framework를 통한 2개의 이미지로 파노라마를 만드는 애플리케이션입니다.
<br /><br />


## 프로젝트 기능
1. 파노라마를 만들 2개의 이미지를 사진첩에서 한번에 선택합니다.
    * PHPicker를 사용한다 - multiselect을 지원하기 때문에 UIImagePicker 대신 사용합니다.
2. openCV framework를 사용해 이미지를 스티칭합니다.
    * openCV C++를 사용하기 위해서 파일 OpenCVWrapper.mm를 이용해 swift 파일과 연결해 사용합니다.
    * openCV에서 이미지 스티칭 기능을 제공하는 stitcher 가 있으나 파노라마 이미지를 만드는 과정을 이해하기 위해 직접 구현합니다.

<br />

### 이미지 스티칭 순서
1. 특징점을 뽑기 전 두 이미지를 Gray이미지로 변환합니다.
```C++
cv::Mat leftGrayImageMat, rightGrayImageMat;
    
    if (leftImageMat.channels() == 1) {
        leftGrayImageMat = leftImageMat;
    } else {
        cvtColor(leftImageMat, leftGrayImageMat, cv::COLOR_BGR2GRAY);
    }
    
    if (rightGrayImageMat.channels() == 1) {
        rightGrayImageMat = rightImageMat;
    } else {
        cvtColor(rightImageMat, rightGrayImageMat, cv::COLOR_BGR2GRAY);
    }
```

2. Sift를 이용해 특징점(keypoints)를 추출 및 디스크립터 계산합니다.
```C++

std::vector<cv::KeyPoint> leftKeyPoints, rightKeyPoints;
    cv::Mat leftDescriptorsMat, rightDescriptorsMat;
    
    cv::Ptr<cv::SIFT> Detector = cv::SIFT::create();
    
    Detector->detectAndCompute(leftGrayImageMat, cv::noArray(), leftKeyPoints, leftDescriptorsMat);
    Detector->detectAndCompute(rightGrayImageMat, cv::noArray(), rightKeyPoints, rightDescriptorsMat);
```

3. 디스크립터를 FLANN matcher를 통해 매칭합니다. 디스크립터 사이의 매칭 결과를 Dmatch 백터에 저장합니다.
```C++
cv::FlannBasedMatcher Matcher;
    std::vector<cv::DMatch> matches;
    
    Matcher.match(leftDescriptorsMat, rightDescriptorsMat, matches);
```

4. 호모그래피를 계산하고 2개의 이미지를 warp 합니다.
```C++
cv::Mat homoMatrix = cv::findHomography(scence, obj, cv::RANSAC);

cv::Mat resultMat;
cv::warpPerspective(rightImageMat, resultMat, homoMatrix, cv::Size(rightImageMat.cols * 2, rightImageMat.rows * 1.2), cv::INTER_CUBIC);
```
<br /><br />


## 시연 영상
<img width="50%" src="https://user-images.githubusercontent.com/50892654/129445442-d99816c7-9fa1-4f94-9eef-4fdc86e7e03c.gif">

<br /><br />

## 사용한 라이브러리
1. [openCV 4.5.3](https://docs.opencv.org/4.5.3/)
2. [PhotoKit](https://developer.apple.com/documentation/photokit)
3. [PHPicker](https://developer.apple.com/videos/play/wwdc2021/10046/)
