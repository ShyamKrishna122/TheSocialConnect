import {
  BaseEntity,
  Column,
  Entity,
  JoinColumn,
  OneToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { UserEntity } from "../../user/entity/user.entity";

@Entity("ScUserInfo")
export class UserInfoEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  id!: string;

  @Column({
    nullable: false,
    unique: false,
  })
  name!: string;

  @Column({
    nullable: false,
  })
  userDp!: string;

  @Column({
    nullable: false,
  })
  userBio!: string;

  @OneToOne(() => UserEntity, (user) => user.info,)
  @JoinColumn()
  user!: UserEntity;
}
