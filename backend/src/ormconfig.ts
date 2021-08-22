import dotenv from "dotenv";
import { join } from "path";
import { ConnectionOptions } from "typeorm";
import { CommentEntity } from "./database/comments/entity/comment.entity";
import { FollowEntity } from "./database/followers/entity/follower.entity";
import { LikeEntity } from "./database/likes/entity/like.entity";
import { PostEntity } from "./database/posts/entity/post.entity";
import { UserEntity } from "./database/user/entity/user.entity";
import { UserInfoEntity } from "./database/userInfo/entity/userInfo.entity";

dotenv.config();

const connectionOptions: ConnectionOptions = {
  type: "postgres",
  host: "localhost",
  port: 5432,
  username: "postgres",
  password: "shyam@123",
  database: "postgres",
  entities: [UserEntity, UserInfoEntity, PostEntity, CommentEntity, LikeEntity,FollowEntity],
  synchronize: true,
  dropSchema: false,
  migrationsRun: true,
  logging: false,
  logger: "debug",
  migrations: [join(__dirname, "src/migration/**/*.ts")],
};

export = connectionOptions;
