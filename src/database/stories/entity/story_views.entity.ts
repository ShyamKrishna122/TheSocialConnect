import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { UserEntity } from "../../user/entity/user.entity";
import { StoryEntity } from "./stories.entity";
import { StoryMediaEntity } from "./stories_media.entity";

@Entity("ScStoryViews")
export class StoryViewEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    viewId!: string;

    @Column({
        nullable: false,
        type: "timestamp",
        default: () => "CURRENT_TIMESTAMP(6)",
    })
    viewTime!: Date;

    @ManyToOne(() => StoryMediaEntity, (storyMedia) => storyMedia.view, {
        onDelete: "CASCADE",
      })
      storyMedia!: StoryMediaEntity;
    
      @ManyToOne(() => UserEntity, (user) => user.view, {
        onDelete: "CASCADE",
      })
      user!: UserEntity;

}