-- Full SN activity Report

SELECT
    u.username,
    u.universe,
    COUNT(DISTINCT p.id) AS total_posts,
    COALESCE(SUM(p.likes), 0) AS total_likes,
    (SELECT COUNT(*) FROM multiverse_sn.friendships f
     WHERE f.user_id_1 = u.id OR f.user_id_2 = u.id) AS friends_count,
    STRING_AGG(DISTINCT g.name, ', ') AS guilds_list,
    u.account_balance
FROM multiverse_sn.users u
         LEFT JOIN multiverse_sn.posts p ON u.id = p.author_id
         LEFT JOIN multiverse_sn.guild_members gm ON u.id = gm.user_id
         LEFT JOIN multiverse_sn.guilds g ON gm.guild_id = g.id
GROUP BY u.id, u.username, u.universe, u.account_balance
HAVING COUNT(DISTINCT p.id) > 0 OR u.account_balance > 100
ORDER BY total_likes DESC, u.account_balance DESC;