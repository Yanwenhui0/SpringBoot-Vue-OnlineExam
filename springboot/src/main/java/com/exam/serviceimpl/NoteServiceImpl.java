package com.exam.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.entity.Note;
import com.exam.mapper.NoteMapper;
import com.exam.service.NoteService;
import com.google.common.collect.ImmutableMap;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author yanwenhui
 * @Date 2020/4/15 11:17
 **/
@Service
public class NoteServiceImpl implements NoteService {

    @Autowired
    private NoteMapper noteMapper;

    @Override
    public void saveNote(Note note) {
        List<Note> buTitle = noteMapper.selectByMap(ImmutableMap.of("title", note.getTitle()));
        if(StringUtils.isBlank(note.getNoteId())) {
            if(CollectionUtils.isNotEmpty(buTitle)) {
                return;
            }
            noteMapper.insert(note);
        } else {
            Note byId = noteMapper.selectById(note.getNoteId());
            if(!StringUtils.equals(byId.getTitle(), note.getTitle())) {
                if(CollectionUtils.isNotEmpty(buTitle)) {
                    return;
                }
            }
            noteMapper.updateById(note);
        }
    }

    @Override
    public void deleteNote(String id) {
        noteMapper.deleteById(id);
    }

    @Override
    public IPage<Note> getNode(String studentId, int page, int size) {
        IPage<Note> iPage = new Page<>(page, size);
        QueryWrapper<Note> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("studentId", studentId);
        IPage<Note> noteIpage = noteMapper.selectPage(iPage, queryWrapper);
        List<Note> records = noteIpage.getRecords();
        records.sort((o1, o2) -> o1.getUpdateTime().before(o2.getUpdateTime()) ? 1 : -1);
        noteIpage.setRecords(records);
        return noteIpage;
    }
}
