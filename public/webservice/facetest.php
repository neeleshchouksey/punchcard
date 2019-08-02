<?php


// namespace and autoloaders
use Ridvanbaluyos\Face\FaceDetection as FaceDetection;
// require_once __DIR__ . '/vendor/autoload.php';

require('../../vendor/autoload.php');

// let's use Justin Bieber's photo
$image = array(
    'url' => 'http://ihos.punchcardllc.com/webservice/1.jpg',
);

// echo '<pre>';print_r($image);die;
// instantiate face detection object
$face = new FaceDetection($image);

// $faceparameter=$face->getFaces(); 

/* 
[{"faceId":"31d18ee4-a0b8-4aaa-b76a-bd962f933abb","faceRectangle":{"top":66,"left":86,"width":77,"height":77}}] 
*/


//$faceparameter= $face->analyzeFaceLandmarks()->getFaces();

/*
[{"faceId":"d61d9ade-f1cb-439d-8649-4de07257ba26","faceRectangle":{"top":66,"left":86,"width":77,"height":77},"faceLandmarks":{"pupilLeft":{"x":111.2,"y":84.9},"pupilRight":{"x":144.5,"y":89.1},"noseTip":{"x":120.9,"y":105.2},"mouthLeft":{"x":110.0,"y":122.8},"mouthRight":{"x":136.5,"y":126.6},"eyebrowLeftOuter":{"x":102.0,"y":77.2},"eyebrowLeftInner":{"x":118.7,"y":79.9},"eyeLeftOuter":{"x":103.9,"y":84.9},"eyeLeftTop":{"x":110.8,"y":82.1},"eyeLeftBottom":{"x":109.6,"y":88.5},"eyeLeftInner":{"x":116.6,"y":87.3},"eyebrowRightInner":{"x":135.3,"y":81.5},"eyebrowRightOuter":{"x":160.7,"y":86.7},"eyeRightInner":{"x":138.4,"y":90.1},"eyeRightTop":{"x":145.1,"y":86.9},"eyeRightBottom":{"x":144.5,"y":93.4},"eyeRightOuter":{"x":151.0,"y":91.6},"noseRootLeft":{"x":121.7,"y":88.5},"noseRootRight":{"x":130.6,"y":89.6},"noseLeftAlarTop":{"x":115.7,"y":99.3},"noseRightAlarTop":{"x":130.4,"y":101.3},"noseLeftAlarOutTip":{"x":112.6,"y":105.6},"noseRightAlarOutTip":{"x":133.3,"y":109.4},"upperLipTop":{"x":120.6,"y":118.2},"upperLipBottom":{"x":120.2,"y":121.4},"underLipTop":{"x":120.5,"y":124.7},"underLipBottom":{"x":119.5,"y":128.4}}}]
*/

 //$faceparameter= $face->analyzeFaceAttributes()->getFaces();

/*
[{"faceId":"4a75cecc-f3cb-4182-82c0-bceda64aa2f4","faceRectangle":{"top":66,"left":86,"width":77,"height":77},"faceAttributes":{"smile":0.118,"headPose":{"pitch":0.0,"roll":9.8,"yaw":-16.1},"gender":"male","age":1.6,"facialHair":{"moustache":0.0,"beard":0.0,"sideburns":0.0},"glasses":"NoGlasses"}}]
*/

 //$faceparameter= $face->analyzeFaceLandmarks()->analyzeFaceAttributes()->getFaces();

/*
[{"faceId":"cf4de466-e32f-4040-a7f2-615e0f10468e","faceRectangle":{"top":66,"left":86,"width":77,"height":77},"faceLandmarks":{"pupilLeft":{"x":111.2,"y":84.9},"pupilRight":{"x":144.5,"y":89.1},"noseTip":{"x":120.9,"y":105.2},"mouthLeft":{"x":110.0,"y":122.8},"mouthRight":{"x":136.5,"y":126.6},"eyebrowLeftOuter":{"x":102.0,"y":77.2},"eyebrowLeftInner":{"x":118.7,"y":79.9},"eyeLeftOuter":{"x":103.9,"y":84.9},"eyeLeftTop":{"x":110.8,"y":82.1},"eyeLeftBottom":{"x":109.6,"y":88.5},"eyeLeftInner":{"x":116.6,"y":87.3},"eyebrowRightInner":{"x":135.3,"y":81.5},"eyebrowRightOuter":{"x":160.7,"y":86.7},"eyeRightInner":{"x":138.4,"y":90.1},"eyeRightTop":{"x":145.1,"y":86.9},"eyeRightBottom":{"x":144.5,"y":93.4},"eyeRightOuter":{"x":151.0,"y":91.6},"noseRootLeft":{"x":121.7,"y":88.5},"noseRootRight":{"x":130.6,"y":89.6},"noseLeftAlarTop":{"x":115.7,"y":99.3},"noseRightAlarTop":{"x":130.4,"y":101.3},"noseLeftAlarOutTip":{"x":112.6,"y":105.6},"noseRightAlarOutTip":{"x":133.3,"y":109.4},"upperLipTop":{"x":120.6,"y":118.2},"upperLipBottom":{"x":120.2,"y":121.4},"underLipTop":{"x":120.5,"y":124.7},"underLipBottom":{"x":119.5,"y":128.4}},"faceAttributes":{"smile":0.118,"headPose":{"pitch":0.0,"roll":9.8,"yaw":-16.1},"gender":"male","age":1.6,"facialHair":{"moustache":0.0,"beard":0.0,"sideburns":0.0},"glasses":"NoGlasses"}}]
*/


$faceparameter= $face->analyzeAll()->getFaces();

/*
[{"faceId":"cf4de466-e32f-4040-a7f2-615e0f10468e","faceRectangle":{"top":66,"left":86,"width":77,"height":77},"faceLandmarks":{"pupilLeft":{"x":111.2,"y":84.9},"pupilRight":{"x":144.5,"y":89.1},"noseTip":{"x":120.9,"y":105.2},"mouthLeft":{"x":110.0,"y":122.8},"mouthRight":{"x":136.5,"y":126.6},"eyebrowLeftOuter":{"x":102.0,"y":77.2},"eyebrowLeftInner":{"x":118.7,"y":79.9},"eyeLeftOuter":{"x":103.9,"y":84.9},"eyeLeftTop":{"x":110.8,"y":82.1},"eyeLeftBottom":{"x":109.6,"y":88.5},"eyeLeftInner":{"x":116.6,"y":87.3},"eyebrowRightInner":{"x":135.3,"y":81.5},"eyebrowRightOuter":{"x":160.7,"y":86.7},"eyeRightInner":{"x":138.4,"y":90.1},"eyeRightTop":{"x":145.1,"y":86.9},"eyeRightBottom":{"x":144.5,"y":93.4},"eyeRightOuter":{"x":151.0,"y":91.6},"noseRootLeft":{"x":121.7,"y":88.5},"noseRootRight":{"x":130.6,"y":89.6},"noseLeftAlarTop":{"x":115.7,"y":99.3},"noseRightAlarTop":{"x":130.4,"y":101.3},"noseLeftAlarOutTip":{"x":112.6,"y":105.6},"noseRightAlarOutTip":{"x":133.3,"y":109.4},"upperLipTop":{"x":120.6,"y":118.2},"upperLipBottom":{"x":120.2,"y":121.4},"underLipTop":{"x":120.5,"y":124.7},"underLipBottom":{"x":119.5,"y":128.4}},"faceAttributes":{"smile":0.118,"headPose":{"pitch":0.0,"roll":9.8,"yaw":-16.1},"gender":"male","age":1.6,"facialHair":{"moustache":0.0,"beard":0.0,"sideburns":0.0},"glasses":"NoGlasses"}}]
*/

echo '<pre>';print_r($faceparameter)
?>