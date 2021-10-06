import {
  BaseEntity,
  Column,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { UserEntity } from "../../user/entity/user.entity";

@Entity("ScStories")
export class StoryEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  storyId!: string;

  @Column({
    type: "timestamp",
    default: () => "CURRENT_TIMESTAMP(6)",
    nullable: false,
  })
  storyTime!: Date;

  @Column({
    type: "simple-array",
    nullable: false,
  })
  storyMedia!: string[];

  @ManyToOne(() => UserEntity, (user) => user.story)
  user!: UserEntity;
}
