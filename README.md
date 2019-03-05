# GitHubApp1
iOS課題ーGithub検索アプリ
[![Build Status](https://app.bitrise.io/app/5c5ec02abe34b4e7/status.svg?token=-0_hNn1C46srVB9BhZIMew&branch=master)](https://app.bitrise.io/app/5c5ec02abe34b4e7)
[![codecov](https://codecov.io/gh/IwanagaSari/GitHubApp1/branch/test/graph/badge.svg)](https://codecov.io/gh/IwanagaSari/GitHubApp1)

## 説明

GitHubのユーザーを閲覧できるクライアントアプリ

## 仕様  

ユーザー一覧画面  
  ・　ユーザー一覧をリストで表示する  
  ・　各行を選択することでユーザーリポジトリ画面に遷移する  

ユーザーリポジトリ画面  
  ・　リスト上部にユーザーの詳細情報を表示する  
  ・　それ以下はforkedリポジトリではないユーザーのリポジトリを一覧表示する  
  ・　リポジトリ一覧の行をタップするとWebViewでリポジトリのURLを表示する 

![Application Structure.pdf](https://github.com/IwanagaSari/GitHubApp1/files/2930821/Application.Structure.pdf)

## 前提条件

  ・ Xcode バージョン 10.1  (10B61)  
  
  ・ iOS 12.1  
  
  ・ macOS 10.13.6  
  
  ・ Swift 4.2.1  
  
  ・ APIは、 https://developer.github.com/v3/ を利用  
  
## アクセストークンの取得

Personal access tokenを持っていない場合、githubアカウントページより作成する必要があります。 

  ①GitHubアカウント内のSettingを選択  
  ②Developer settingを選択  
  ③OAuthApps内のPersonal access tokensを選択  
  ④Generate new tokenyを選択し、アカウントパスワードを入力  
  ⑤Token descriptionを入力する  
  ⑥Slect scopes内で、以下の項目にチェックを入れる。  
　　  ☑︎repo  
　　  ☑︎user  
  ⑦Generate tokenよりアクセストークンを作成  

