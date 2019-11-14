---
layout: post
title: "Getting started"
date: 2019-11-14 13:29:56 +0900
update: 2019-11-14 14:07:26 +0900
categories: ['guide']
---

* TOC
{:toc}

# 쉘 스크립트 시작하기

쉘 스크립트를 만들고 성공적으로 실행하려면 3가지 작업이 필요하다.

1. **스크립트 작성하기**
2. **스크립트를 실행파일로 설정하기**
3. **쉘이 접근할 수 있는 장소에 저장하기**

# 01 스크립트 작성하기

편집기로 `hello_world` 파일을 만든다.

```console
$ vi hello_world
```

다음과 같은 내용을 작성한다.

```bash
#!/bin/bash

# This is our first script.

echo 'Hello World!'
```

* `#`: 주석이므로 `#` 뒤에 나오는 모든 내용이 무시된다.
* `#!`: shebang[셔뱅]. 뒤따라오는 스크립트를 실행할 인터프리터의 이름(ex. bash)을 시스템에 알려준다. 모든 쉘 스크립트의 첫 줄에는 shebang이 반드시 포함되어야 한다.

# 02 스크립트를 실행파일로 설정하기

시스템은 여러 이유들로 예전 텍스트 파일들을 프로그램으로 처리하지 않는다. 따라서 스크립트 파일에 실행 권한을 주어야 한다.

```console
$ chomod 755 hello_world
```

스크립트에 실행 퍼미션을 설정하는 일반적인 방법은 두 가지가 있다:

* `755`: 모든 사용자에게 실행 권한을 준다.
* `700`: 파일 소유자만 실행 가능하다.

여기서 주의할 점은 실행을 위해 항상 읽기 권한이 설정되어야 한다는 것이다.

# 03 쉘이 접근할 수 있는 장소에 저장하기

2단계에서 퍼미션 설정을 하고 나면 스크립트를 실행할 수 있다.

```console
$ ./hello_world
Hello World!
```

만약 스크립트를 실행할 때 스크립트명 앞에 정확한 경로명을 입력하지 않으면 다음과 같은 에러 메시지가 나온다.

```console
$ hello_world
bash: hello_world: command not found
```

왜 이럴까? 

* 쉘은 경로명이 명시되어 있지 않아도 실행 가능한 파일들이 존재하는 특정 디렉토리를 자동으로 검색한다. 
* 디렉토리 목록은 PATH라는 환경 변수에 규정되어 있다.
* 우리가 작성한 스크립트가 PATH에 있는 디렉토리들 가운데 저장되어 있지 않다면 실행할 수 없다.

PATH 내용을 확인해보자.

```console
$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

우리가 작성한 스크립트가 위에 나열된 디렉토리들 가운데 하나에라도 저장되어 있다면 경로 지정 없이 쉘 스크립트 파일을 실행할 수 있다.

따라서 우리는 bin 디렉토리를 새로 생성하고, 그 디렉토리에 스크립트 파일을 저장하고 다른 프로그램처럼 경로 지정 없이 실행할 것이다.

쉘은 경로명이 명시되어 있지 않아도 실행 가능한 파일들이 존재하는 특정 디렉토리를 자동으로 검색한다. 우리는 최대한의 편의를 위해 이 디렉토리에 작업한 스크립트를 저장할 것이다.

```console
$ cd ~
$ mkdir bin
```

`hello_world` 파일을 `bin` 디렉토리로 옮긴다.

```console
$ mv hello_world bin
```

만약 PATH 변수에 bin 디렉토리가 포함되어 있지 않다면 `.bashrc` 파일에 다음의 내용을 입력하여 bin 디렉토리를 추가한다.

```bash
export PATH=~/bin:"$PATH"
```

`.bashrc` 파일을 쉘이 다시 읽어 들이도록 하자.

```console
$ . .bashrc
```

PATH를 다시 확인해보면 `~/bin`이 추가되어 있다.

```console
$ echo $PATH
/Users/jay/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

> 필자의 home 디렉토리 주소는 `/Users/jay/`이다. 참고로 home 디렉토리는 `~`로도 표현한다.

이제 경로 지정 없이 쉘 스크립트를 실행할 수 있다.

```console
$ hello_world
Hello World!
```
