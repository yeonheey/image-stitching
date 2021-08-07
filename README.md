# Image Stitching (iOS)
## 프로젝트 개요
2개의 이미지로 파노라마 이미지를 만드는 애플리케이션.

<br /><br />

## 기능 및 라이브러리
1. 파노라마를 만들 2개의 이미지를 사진첩에서 한번에 선택한다.
    * PHPicker를 사용한다 - multiselect을 지원하기 때문에 UIImagePicker 대신 사용한다.
2. openCV framework를 사용해 이미지를 스티칭한다.
    * openCV C++를 사용하기 위해서 파일 OpenCVWrapper.mm를 이용해 swift 파일과 연결해 사용한다.

<br /><br />

## 시연 영상
##### PHPicker를 이용해 2개의 이미지를 고른다.
<img width="80%" src="https://user-images.githubusercontent.com/50892654/128601549-9fcbcf1e-b2b7-475b-ba8b-54dd3a82b439.gif">

##### openCV framework를 활용한 이미지 스티칭 결과를 보여준다.
<img width="90%" src="">
