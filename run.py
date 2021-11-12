import os
import json
import base64
import datetime
from urllib import parse
import requests

class Gitee:
    def __init__(self, access_token, owner, repo) -> None:
        self._access_token = access_token
        self._params = (('access_token', access_token), )
        self._owner = owner
        self._repo = repo
        self._headers = {
            'Content-Type': 'application/json;charset=UTF-8',
        }

    def update(self,
               repo_file_path: str,
               local_file_path="",
               string="",
               b64=""):
        path = repo_file_path.replace("/", "%2F")
        url = f"https://gitee.com/api/v5/repos/{self._owner}/{self._repo}/contents/{path}"
        if local_file_path:
            with open(local_file_path, "r") as f:
                content = base64.b64encode(f.read().encode()).decode()
        elif string:
            content = base64.b64encode(str(string).encode()).decode()
        elif b64:
            content = b64
        else:
            raise "无源文件"
        file_info = self.getInfo(repo_file_path)
        if not file_info:
            self.mkfile(repo_file_path, content)
        else:
            data = str({
                "access_token": self._access_token,
                "content": content,
                "sha": file_info['sha'],
                "message": "update",
                "committer[name]":"talking-toaster",
                "author[name]":"talking-toaster"
            }).replace("'", '"')

            response = requests.put(url, headers=self._headers, data=data)
            if response.status_code == 400:
                print("update请求错误", response.status_code)
            else:
                # print(response.text)
                print(response.status_code)

    def mkfile(self, repo_file_path, content="ZmlsZQ=="):
        owner = self._owner
        repo = self._repo
        path = repo_file_path.replace("/", "%2F")
        url = f"https://gitee.com/api/v5/repos/{owner}/{repo}/contents/{path}"

        data = str({
            "access_token": self._access_token,
            "content": content,
            "message": "update"
        }).replace("'", '"')

        response = requests.post(url, headers=self._headers, data=data)
        if response.status_code == 400:
            print("mkfile请求错误", response.status_code)
        else:
            # print(response.text)
            print(response.status_code)

    def getInfo(self, repo_file_path: str = 'test/2.py'):
        owner = self._owner
        repo = self._repo
        path = repo_file_path.replace("/", "%2F")
        url = f"https://gitee.com/api/v5/repos/{owner}/{repo}/contents/{path}"
        response = requests.get(url,
                                headers=self._headers,
                                params=self._params)
        return response.json()


m = datetime.datetime.now().month
d = datetime.datetime.now().day

access_token = os.environ["GITEE_ACCESS_TOKEN"]
nodes_str = os.environ["NODES"]

nodes = json.loads(nodes_str)
gitee = Gitee(access_token,"talking-toaster","apis")

for k,v in nodes.items():
    file_name = k
    url = v if k != "zyfxz" else v+str(m) + str(d)
    node = requests.get(url).text
    gitee.update("nodes/"+file_name,string=node)

