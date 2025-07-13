external_url "http://gitlab"              # コンテナ内部用
gitlab_rails['gitlab_host'] = 'localhost'  # ブラウザアクセス用
gitlab_rails['gitlab_port'] = 8080          # ブラウザアクセス用
registry_external_url "http://gitlab:4567"      # Dockerレジストリ用
gitlab_rails['time_zone'] = 'Asia/Tokyo'
# 任意のパスワードを設定する方法
# gitlab_rails['initial_root_password'] = 'password'  # 任意のパスワードを設定
# gitlab_rails['store_initial_root_password'] = false  # initial_root_passwordファイルを作成しない
# gitlab_rails['initial_shared_runners_registration_token'] = 'token-AABBCCDD'  # GitLab 16.0+ では削除された
# 新しいランナー登録方式を使用する必要があります
puma['enable'] = true
sidekiq['enable'] = true
