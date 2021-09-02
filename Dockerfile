FROM node:12.10.0-alpine AS base

# 设置环境变量
ENV SERVER_PATH=/server

# 暴露端口
EXPOSE 8047

# 设置工作目录
WORKDIR $SERVER_PATH

# 安装pm2
RUN yarn global add pm2

# 基于base镜像 安装依赖阶段
FROM base AS install

COPY package.json yarn.lock ./

# 安装依赖
RUN yarn

FROM base

# 将安装依赖阶段中生成的node_modules目录复制到工作目录
COPY --from=install $SERVER_PATH/node_modules ./node_modules

# 把当前目录下的所有文件拷贝到镜像的工作目录
COPY . .

# 镜像运行后执行的node服务启动命令
CMD ["pm2", "start", "src/index.js", "--no-daemon"]
