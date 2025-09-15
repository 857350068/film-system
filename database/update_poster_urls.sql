-- 更新电影海报URL为本地静态资源路径
USE film_rating_system;

-- 更新海报URL为本地静态资源路径
UPDATE movies SET poster_url = '/images/movies/AFanDa.jpg' WHERE title = '阿凡达';
UPDATE movies SET poster_url = '/images/movies/TaiTanNiKeHao.jpg' WHERE title = '泰坦尼克号';
UPDATE movies SET poster_url = '/images/movies/FuChouZheLianMeng.jpg' WHERE title = '复仇者联盟';
UPDATE movies SET poster_url = '/images/movies/XiaoShengKeDeJiuShu.JPG' WHERE title = '肖申克的救赎';
UPDATE movies SET poster_url = '/images/movies/DaoMengKongJian.JPG' WHERE title = '盗梦空间';
UPDATE movies SET poster_url = '/images/movies/LiuLangDiQiu.JPG' WHERE title = '流浪地球';
UPDATE movies SET poster_url = '/images/movies/NeZhaZhiMoTongNaoHai.JPG' WHERE title = '哪吒之魔童降世';
UPDATE movies SET poster_url = '/images/movies/XinJiChuanYue.JPG' WHERE title = '星际穿越';
UPDATE movies SET poster_url = '/images/movies/NiDeMingZi.JPG' WHERE title = '你的名字';
UPDATE movies SET poster_url = '/images/movies/HeiBao.JPG' WHERE title = '黑豹';
UPDATE movies SET poster_url = '/images/movies/JIAOFU.JPG' WHERE title = '教父';
UPDATE movies SET poster_url = '/images/movies/QIANYUQIANXUN.JPG' WHERE title = '千与千寻';
UPDATE movies SET poster_url = '/images/movies/WOBUSHIYAOSHENG.JPG' WHERE title = '我不是药神';
UPDATE movies SET poster_url = '/images/movies/JISHENGCHONG.JPG' WHERE title = '寄生虫';
UPDATE movies SET poster_url = '/images/movies/FENGKUANGDONGWUCHENG.JPG' WHERE title = '疯狂动物城';
UPDATE movies SET poster_url = '/images/movies/WUJIANDAO.JPG' WHERE title = '无间道';
UPDATE movies SET poster_url = '/images/movies/RangZiDanFei.JPG' WHERE title = '让子弹飞';
UPDATE movies SET poster_url = '/images/movies/ShuaiJiaoBaBaBa.JPG' WHERE title = '摔跤吧！爸爸';
UPDATE movies SET poster_url = '/images/movies/DaHuaXiYouZhiDaShengQUQin.JPG' WHERE title = '大话西游之大圣娶亲';
UPDATE movies SET poster_url = '/images/movies/HaiShangGangQinShi.JPG' WHERE title = '海上钢琴师';

-- 验证更新结果
SELECT id, title, poster_url FROM movies ORDER BY id;