class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  skip_before_action :verify_authenticity_token, raise: false

  # ログイン処理
  # rubocop:disable Lint/UnlessMethodDefinition
  def create
    # user = User.find_by(email: params[:email])
    # if user && user.valid_password?(params[:password])

    #   # トークンを生成
    #   token = user.create_new_auth_token

    #   # トークン情報をJSON形式で返す
    #   render json: {
    #     data: user.as_json.merge({
    #       access_token: token['access-token'],
    #       client: token['client'],
    #       uid: token['uid']
    #     })
    #   }, status: :ok
    # else
    #   render json: { error: 'Invalid email or password' }, status: :unauthorized
    # end
    # rubocop:enable Lint/UnlessMethodDefinition
    super
  end
end
