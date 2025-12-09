# TL & Lua チュートリアル

このプロジェクトは、Luaの特徴的な機能（table,first-class関数,オブジェクト指向）をTLで実装したデモです。

## セットアップ

```shell
devbox shell
luarocks install tl --local
PATH=$PATH:~/.luarocks/bin
```

## 実行方法

### TLファイルを型チェックして実行する方法

```shell
# TLファイルを型チェック
tl check main.tl

# TLファイルをLuaファイルに変換
tl gen main.tl

# 生成されたLuaファイルを実行
lua test_main.lua
```
