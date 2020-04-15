package com.exam.controller;

import com.exam.entity.ApiResult;
import com.exam.entity.Note;
import com.exam.service.NoteService;
import com.exam.util.ApiResultHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @Author yanwenhui
 * @Date 2020/4/15 11:17
 **/
@RestController
@Validated
@RequestMapping("note")
public class NoteController {

    @Autowired
    private NoteService noteService;

    @PostMapping({"","/"})
    public ApiResult saveNote(@RequestBody Note note) {
        noteService.saveNote(note);
        return ApiResultHandler.buildApiResult(200, "save note successfully.", null);
    }

    @DeleteMapping("/{noteId}")
    public ApiResult deleteNote(@NotBlank @PathVariable String noteId) {
        noteService.deleteNote(noteId);
        return ApiResultHandler.buildApiResult(200, "delete note successfully.", null);
    }

    @GetMapping("/{studentId}/{page}/{size}")
    public ApiResult getNote(@NotBlank @PathVariable String studentId,
                             @NotNull @PathVariable Integer page,
                             @NotNull @PathVariable Integer size) {
        return ApiResultHandler.buildApiResult(200, "get note list.", noteService.getNode(studentId, page, size));
    }

}
