import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { PostEntity } from "../../posts/entity/post.entity";
import { UserEntity } from "../../user/entity/user.entity";

@Entity("ScComments")
export class CommentEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  commentId!: string;

  @Column({
    nullable: false,
    type: "timestamp",
    default: () => "CURRENT_TIMESTAMP(6)",
  })
  commentTime!: Date;

  @Column({
    nullable: false,
  })
  commentText!: string;

  @ManyToOne(() => PostEntity, (post) => post.comment, { onDelete: 'CASCADE' })
  post!: PostEntity;

  @ManyToOne(() => UserEntity, (user) => user.comment)
  user!: UserEntity;
}
