# Image Stitching
## 프로젝트 개요
opencv framework를 통한 2개의 이미지로 파노라마를 만드는 애플리케이션입니다.

<br />

## 기능 및 라이브러리
1. 파노라마를 만들 2개의 이미지를 사진첩에서 한번에 선택합니다.
    * PHPicker를 사용한다 - multiselect을 지원하기 때문에 UIImagePicker 대신 사용합니다.
2. openCV framework를 사용해 이미지를 스티칭합니다.
    * openCV C++를 사용하기 위해서 파일 OpenCVWrapper.mm를 이용해 swift 파일과 연결해 사용합니다.

<br />

## 시연 영상
#### PHPicker를 이용해 2개의 이미지를 사진첩에서 고릅니다.
<img width="50%" src="https://user-images.githubusercontent.com/50892654/128601549-9fcbcf1e-b2b7-475b-ba8b-54dd3a82b439.gif">

#### openCV framework를 활용한 이미지 스티칭 결과를 보여줍니다.
<img width="90%" src="">
