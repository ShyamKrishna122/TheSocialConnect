import dotenv from "dotenv";
import { join } from "path";
import { ConnectionOptions } from "typeorm";
import { CommentEntity } from "./database/comments/entity/comment.entity";
import { FollowEntity } from "./database/followers/entity/follower.entity";
import { LikeEntity } from "./database/likes/entity/like.entity";
import { PostEntity } from "./database/posts/entity/post.entity";
import { PostMediaEntity } from "./database/posts/entity/post_media.entity";
import { StoryEntity } from "./database/stories/entity/stories.entity";
import { UserEntity } from "./database/user/entity/user.entity";
import { UserInfoEntity } from "./database/userInfo/entity/userInfo.entity";

dotenv.config();

const connectionOptions: ConnectionOptions = {
  url: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false },
  type: "postgres",
  host: process.env.Host || "localhost",
  port: Number(process.env.DB_Port) || 5432,
  username: process.env.User || "postgres",
  password: process.env.DB_Password || process.env.PASSWORD,
  database: process.env.Database || "postgres",
  entities: [
    UserEntity,
    UserInfoEntity,
    PostEntity,
    CommentEntity,
    LikeEntity,
    FollowEntity,
    StoryEntity,
    PostMediaEntity,
  ],
  synchronize: true,
  dropSchema: false,
  migrationsRun: true,
  logging: false,
  logger: "debug",
  migrations: [join(__dirname, "src/migration/**/*.ts")],
};

export = connectionOptions;
