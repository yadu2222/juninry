class Urls {
  // base URL
  static const String protocol = 'http://';


  // ループバックアドレス使いたい人におすすめ
  // static const String host = '127.0.0.1';

  // Androidエミュレーターにおすすめ

  // static const String host = '10.200.1.53';
  // static const String host = '127.0.0.1';

  // static const String host = '10.0.2.2';

  // iOSエミュレーターにおすすめ
  // static const String host = 'localhost';
  // static const String host = 'm2.local';

  // ローカル環境
  // static const String host = '10.200.0.220';
  static const String host = '192.168.33.168';
  // static const String host = '192.168.0.12';

  static const String port = '4561';
  static const String baseUrl = '$protocol$host:$port';
  static const String version = '/v1'; // version

  // ここにURLを追加していく
  // user
  static const String registerUser = '$version/users/register'; // POSTユーザー登録
  static const String login = '$version/users/login'; // POSTログイン
  static const String getUser = '$version/auth/users/user'; // GETuser情報取得

  // notice
  static const String getNotices = '$version/auth/users/notices/notices'; // GETお知らせ取得
  static const String noticeRead = '$version/auth/users/notices/read/'; // POST既読
  static const String noticeDetail = '$version/auth/users/notices/'; // GETお知らせ詳細
  static const String noticeRegister = '$version/auth/users/notices/register'; // POSTお知らせ登録
  static const String noticeFilters = '$version/auth/users/notices/filters'; // GETお知らせフィルタリング取得
  static const String noticeReadStatus = '$version/auth/users/notices/status/';  // GET生徒の既読状態


  // homework
  static const String getHomeworks = '$version/auth/users/homeworks/upcoming'; // GET宿題取得
  static const String getNextdayHomeworks = '$version/auth/users/homeworks/nextday'; // GETつぎのひの宿題取得
  static const String submittionHomework = '$version/auth/users/homeworks/submit'; // POST宿題提出
  static const String submissionLog = '$version/auth/users/homeworks/record?targetMonth='; // POST宿題提出履歴取得
  static const String registerHomework = '$version/auth/users/homeworks/register'; // POST宿題登録
  static const String getTeachingItems = '$version/auth/users/homeworks/tmaterials'; // GET教材取得
  static const String homeworkSubmittionInfo = '$version/auth/users/homeworks/submit'; // GET提出情報取得

  // class
  static const String getClassmates = '$version/auth/users/classes/users'; // GETクラスメイト取得
  static const String joinClass = '$version/auth/users/classes/join'; // POSTクラス参加
  static const String createClass = '$version/auth/users/classes/register'; // POSTクラス作成  static const String createClass = '$version/auth/users/classes/register'; // POSTクラス作成
  static const String inviteClass = '$version/auth/users/classes/refresh'; // POST招待コード再発行
  static const String getClasses = '$version/auth/users/classes/affiliations'; // GETクラス一覧取得

  // OUCHI
  static const String joinOUCHI = '$version/auth/users/ouchies/join'; // POST招待コードでOUCHIに参加
  static const String createOUCHI = '$version/auth/users/ouchies/register'; // POSTクラス作成  static const String createClass = '$version/auth/users/classes/register'; // POSTクラス作成
  static const String friendLineAccount = '$version/auth/users/ouchies/line'; // GETLINEアカウントと連携
  static const String getOUCHIInfo = '$version/auth/users/ouchies/info'; // GETOUCHI情報取得

  // help
  static const String getHelp = '$version/auth/users/ouchies/helps/helps'; // GETおてつだい取得
  static const String destionHelp = '$version/auth/users/ouchies/helps/submittion'; // POSTおてつだい消化
  static const String registerHelp = '$version/auth/users/ouchies/helps/register'; // POSTおてつだい登録

  // GOHOUBI
  static const String getRewards = '$version/auth/users/ouchies/rewards/rewards'; // GETごほうび取得
  static const String exchangeReward = '$version/auth/users/ouchies/rewards/exchange'; // POSTごほうび交換
  static const String registerReward = '$version/auth/users/ouchies/rewards/register'; // POSTごほうび登録
  static const String getExchanges = '$version/auth/users/ouchies/rewards/exchanges'; // GET交換履歴取得
  static const String digestionExchange = '$version/auth/users/ouchies/rewards/digestion'; // POST交換消化
}
