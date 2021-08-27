import {
  BaseEntity,
  Column,
  Entity,
  JoinColumn,
  OneToMany,
  OneToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CommentEntity } from "../../comments/entity/comment.entity";
import { FollowEntity } from "../../followers/entity/follower.entity";
import { LikeEntity } from "../../likes/entity/like.entity";
import { PostEntity } from "../../posts/entity/post.entity";
import { UserInfoEntity } from "../../userInfo/entity/userInfo.entity";

@Entity("scUsers")
export class UserEntity extends BaseEntity {
  @PrimaryGeneratedColumn("uuid")
  id!: string;

  @Column({
    nullable: false,
    unique: true,
  })
  userName!: string;

  @Column({
    nullable: false,
    unique: true,
  })
  userEmail!: string;

  @Column({
    nullable: false,
    unique: false,
  })
  userPassword!: string;

  @OneToOne(() => UserInfoEntity, (info) => info.user)
  info!: UserInfoEntity;

  @OneToMany(() => PostEntity, (post) => post.user)
  @JoinColumn()
  post!: PostEntity[];

  @OneToMany(() => CommentEntity, (comment) => comment.user)
  @JoinColumn()
  comment!: CommentEntity[];

  @OneToMany(() => LikeEntity, (like) => like.user)
  @JoinColumn()
  like!: LikeEntity[];

  @OneToMany(() => FollowEntity, (follow) => follow.user)
  @JoinColumn()
  follow!: FollowEntity[];
}
