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

@Entity("ScPosts")
export class PostEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  postId!: string;

  @Column({
    nullable: false,
  })
  postTitle!: string;

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
    type: "simple-array",
    nullable: false,
  })
  postMedia!: string[];

  @Column({
    nullable: false,
  })
  postType!: number;

  @ManyToOne(() => UserEntity, (user) => user.post)
  user!: UserEntity;

  @OneToMany(() => CommentEntity, (comment) => comment.post)
  @JoinColumn()
  comment!: CommentEntity[];

  @OneToMany(() => LikeEntity, (like) => like.post)
  @JoinColumn()
  like!: LikeEntity[];
}
