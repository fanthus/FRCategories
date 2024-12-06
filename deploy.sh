#!/bin/bash

# 检查是否提供了 tag 参数
if [ -z "$1" ]; then
    echo "Usage: $0 <tag>"
    exit 1
fi

TAG=$1

# 执行 git tag 命令
echo "execute local tag $TAG"
git tag "$TAG"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create git tag $TAG"
    exit 1
fi
echo "push tag to server"
git push --tag
if [ $? -ne 0 ]; then
    echo "Error: Failed to push git tag $TAG"
    exit 1
fi

# 修改 FRCategories.podspec 文件的 spec.version 字段
PODSPEC_FILE="FRCategories.podspec"

if [ ! -f "$PODSPEC_FILE" ]; then
    echo "Error: $PODSPEC_FILE not found!"
    exit 1
fi

# 替换本地podspec文件
echo "replace podspec file version"
sed -i '' "s/spec\.version.*=.*\"[^\"]*\"/spec.version = \"$TAG\"/g" $PODSPEC_FILE
if [ $? -ne 0 ]; then
    echo "Error: Failed to update spec.version in $PODSPEC_FILE"
    exit 1
fi

# 本地验证
echo ">>>>>> begin local trunk push"
pod lib lint --verbose --allow-warnings
if [ $? -ne 0 ]; then
    echo "Error: Failed local validated"
    exit 1
fi
echo "<<<<<< end local trunk push"

# POD服务端验证
echo ">>>>>> begin pod trunk push"
pod trunk push $PODSPEC_FILE --allow-warnings
if [ $? -ne 0 ]; then
    echo "Error: Failed server validated"
    exit 1
fi

echo "publish success!🎉🎉"


