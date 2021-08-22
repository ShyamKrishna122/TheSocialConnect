import {
  BaseEntity,
  Column,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { UserEntity } from "../../user/entity/user.entity";

@Entity("ScFollow")
export class FollowEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  id!: string;

  @Column({
    nullable: false,
  })
  followerId!: string;

  @ManyToOne(() => UserEntity, (user) => user.follow, {
    onDelete: "CASCADE",
  })
  user!: UserEntity;
}
