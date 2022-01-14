import {
  BaseEntity,
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { UserEntity } from "../../user/entity/user.entity";
import { StoryMediaEntity } from "./stories_media.entity";
import { StoryViewEntity } from "./story_views.entity";

@Entity("ScStories")
export class StoryEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  storyId!: string;

  @ManyToOne(() => UserEntity, (user) => user.story)
  user!: UserEntity;

  @OneToMany(() => StoryMediaEntity, (storyMedia) => storyMedia.story)
  @JoinColumn()
  storyMedia!: StoryMediaEntity[];
}
