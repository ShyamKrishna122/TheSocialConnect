import { BaseEntity, Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { StoryEntity } from "./stories.entity";
import { StoryViewEntity } from "./story_views.entity";

@Entity("ScStoryMedia")
export class StoryMediaEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    storyMediaId!: string;

    @Column({
        nullable: false,
    })
    mediaType!: string;

    @Column({
        nullable: false,
    })
    mediaUrl!: string;

    @Column({
        type: "timestamp",
        default: () => "CURRENT_TIMESTAMP(6)",
        nullable: false,
    })
    storyTime!: Date;

    @ManyToOne(() => StoryEntity, (story) => story.storyMedia, { onDelete: 'CASCADE' })
    story!: StoryEntity;

    @OneToMany(() => StoryViewEntity, (view) => view.storyMedia)
    @JoinColumn()
    view!: StoryViewEntity[];

}