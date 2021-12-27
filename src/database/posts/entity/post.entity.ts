import {
  BaseEntity,
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CommentEntity } from "../../comments/entity/comment.entity";
import { LikeEntity } from "../../likes/entity/like.entity";
import { UserEntity } from "../../user/entity/user.entity";
import { PostMediaEntity } from "./post_media.entity";

@Entity("ScPosts")
export class PostEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  postId!: string;

  @Column({
    nullable: false,
  })
  postDescription!: string;

  @Column({
    type: "timestamp",
    default: () => "CURRENT_TIMESTAMP(6)",
    nullable: false,
  })
  postTime!: Date;

  @Column({
    nullable: false,
  })
  type!: number;

  @Column({
    type: "boolean",
    nullable: false,
  })
  imageType!:boolean;

  @ManyToOne(() => UserEntity, (user) => user.post)
  user!: UserEntity;

  @OneToMany(() => PostMediaEntity, (postMedia) => postMedia.post)
  @JoinColumn()
  postMedia!: PostMediaEntity[];

  @OneToMany(() => CommentEntity, (comment) => comment.post)
  @JoinColumn()
  comment!: CommentEntity[];

  @OneToMany(() => LikeEntity, (like) => like.post)
  @JoinColumn()
  like!: LikeEntity[];
}
