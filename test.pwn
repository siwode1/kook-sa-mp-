#include <a_samp>
#include <strlib>
#include <GBKToUTF8>
#include <requests>
/*
定义要发送的频道
*/
new RequestsClient:joinserver; //比如谁加入了服务器
KOOK_MessageID()
{
joinserver = RequestsClient("把你的回调地址放在这里");
}
main()
{
KOOK_MessageID(); //频道ID
}
KOOK_Message(RequestsClient:client, const string[])
{
new utf8Text[128];
GbkToUtf8(utf8Text, string);
RequestJSON(
client,
"",
HTTP_METHOD_POST,
"OnPostJson",
JsonObject(
"content", JsonString(utf8Text)
),
RequestHeaders("Content-Type", "application/json")
);
}
forward OnPostJson(Request:id, E_HTTP_STATUS:status, Node:node);
public OnPostJson(Request:id, E_HTTP_STATUS:status, Node:node)
{
if(status == HTTP_STATUS_OK)
{
printf("发送成功！");
}
else
{
printf("发送失败");
}
}
public OnplayerConnect(playerid)
{
new name[MAX_PLAYER_NAME + 1], string[128];
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "*** %s 进入了服务器", name);
KOOK_Message(joinserver, string);
}
