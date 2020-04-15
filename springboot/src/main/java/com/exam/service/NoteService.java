package com.exam.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.exam.entity.Note;

/**
 * @Author yanwenhui
 * @Date 2020/4/15 11:16
 **/
public interface NoteService {

    void saveNote(Note note);

    void deleteNote(String id);

    IPage<Note> getNode(String studentId, int page, int size);

}
