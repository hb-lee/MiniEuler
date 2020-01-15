##### 下载项目
git clone https://github.com/hb-lee/MiniEuler.git

##### 文件说明
- makeBase.sh  
这个脚本用于在openEuler OS arm64平台上构建最小的基础容器(OCI标准）镜像，所构建的镜像所包含的功能有：`vim`, `bash`, `yum`；可以直接执行`bash makeBase.sh`即可！所构建的镜像可以被`iSulad`加载并运行；这个脚本会用到的`Dockerfile`为`Dockerfile_baseos`；

- Dockerfile_baseos
这个文件是在openEuler OS arm64平台上构建上述基础镜像用到的`Dockerfile`文件；用这个`Dockerfile`构建的基础镜像大小为`439MB`；

> 利用`docker`的相关指令可以把这个基础镜像`push`到`DockerHub`仓库，从而可以供第二阶段使用；

- imagetool.sh
这个脚本用于在`X86`平台上构建`arm64`平台上能运行的镜像，而且构建的镜像可以被`iSulad`加载并运行；该镜像在第一阶段构建的基础上新增加了`httpd`服务；这个脚本考虑了用户构建机器为`CentOS`和`Ubuntu`，具体一点是考虑了安装一些软件的不同；这个脚本将会用到的`Dockerfile`为`Dockerfile_app`，在运行此脚本时需要执行`init_env.sh`来初始化一些环境；

> `httpd`服务的开启需要进入容器并修改`/etc/httpd/conf/httpd.conf`中的`ServerName localhost:80`并创建一个`index.html`；然后启动`httpd`服务（`httpd -k start`）；

- init_env.sh
这个脚本用于在`X86`平台上构建`arm64`平台上能运行的镜像时初始化环境；

- Dockerfile_app
这个文件是在`X86`机器上构建基于上述基础镜像新增`httpd`服务的镜像所需要的`Dockerfile`文件；用这个文件构建的基于基础镜像的最小`httpd`服务镜像大小为`1.32GB`；

- MiniEuler.tar.gz
这个压缩包为构建最小基础容器镜像所用到的应用包列表；基于此我们可以用来构建一个最小的`Euler OS`内核镜像；