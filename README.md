# Browser Use Docker Environment

ブラウザ自動操作ツール「Browser Use」をDocker環境で実行するための設定です。日本語環境に対応しており、Web経由でブラウザの操作画面にアクセスできます。

## 環境構築手順

### 1. 必要な環境
- Docker
- Docker Compose

### 2. セットアップ

#### 2.1 リポジトリのクローン
```bash
git clone <repository-url>
cd <repository-name>
```

#### 2.2 環境変数の設定
```bash
# .env.exampleをコピーして.envを作成
cp .env.example .env

# .envファイルを編集し、必要なAPIキーを設定
# 以下の項目を設定してください：
# - OPENAI_API_KEY=your_openai_api_key
# - ANTHROPIC_API_KEY=your_anthropic_api_key（オプション）
```

### 3. Dockerコンテナの起動

#### 3.1 コンテナのビルドと起動
```bash
# コンテナのビルドと起動
docker-compose up --build

# または、バックグラウンドで実行する場合
docker-compose up -d --build
```

### 4. ブラウザ操作画面へのアクセス

1. Webブラウザで以下のURLにアクセス：
```
http://localhost:6080
```

2. 認証情報の入力：
- パスワード: `your_password`

### 5. Browser Useの実行

1. 仮想デスクトップ内でターミナルを開く
2. 以下のコマンドを実行：
```bash
python ./browser-use.py
```

## 補足情報

### デフォルトの認証情報
- VNCパスワード: `your_password`
  - セキュリティのため、本番環境では必ず変更してください

### トラブルシューティング

コンテナが正常に起動しない場合は、以下のコマンドでログを確認できます：
```bash
docker-compose logs
```

### コンテナの停止
```bash
docker-compose down
```

## 注意事項

- 本番環境で使用する場合は、セキュリティ設定を適切に行ってください
- APIキーは厳重に管理し、Gitリポジトリにコミットしないよう注意してください