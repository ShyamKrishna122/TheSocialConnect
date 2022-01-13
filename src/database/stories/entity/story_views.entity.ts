import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { UserEntity } from "../../user/entity/user.entity";
import { StoryEntity } from "./stories.entity";

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

    @ManyToOne(() => StoryEntity, (story) => story.view, {
        onDelete: "CASCADE",
      })
      story!: StoryEntity;
    
      @ManyToOne(() => UserEntity, (user) => user.view, {
        onDelete: "CASCADE",
      })
      user!: UserEntity;

}