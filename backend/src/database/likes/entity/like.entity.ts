import {
  BaseEntity,
  Column,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { PostEntity } from "../../posts/entity/post.entity";
import { UserEntity } from "../../user/entity/user.entity";

@Entity("ScLikes")
export class LikeEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  likeId!: string;

  @Column({
    nullable: false,
    type: "timestamp",
    default: () => "CURRENT_TIMESTAMP(6)",
  })
  likeTime!: Date;

  @ManyToOne(() => PostEntity, (post) => post.like, {
    onDelete: "CASCADE",
  })
  post!: PostEntity;

  @ManyToOne(() => UserEntity, (user) => user.like, {
    onDelete: "CASCADE",
  })
  user!: UserEntity;
}
