//
//  P3DAppInterface.h
//  Present3D-Control
//
//  Created by Stephan Huber on 15.10.13.
//  Copyright (c) 2013 Stephan Huber. All rights reserved.
//

#pragma once

#include <vector>
#include <map>
#include <set>
#include <string>
#include <osg/Referenced>
#include <osg/ref_ptr>
#include <osg/Node>

#include "FileCollection.h"
#include "ReadFileThread.h"
#include "ReadFileCompleteHandler.h"

class P3DAppInterface : public osg::Referenced {
public:
    
 
    
   
    
    typedef std::set<std::string> SupportedFileTypesSet;
    typedef std::map<FileCollection::Type, osg::ref_ptr<FileCollection> > FilesMap;
    P3DAppInterface();
    
    static P3DAppInterface* instance();
    
    FileCollection* getFiles(FileCollection::Type type) {
        FilesMap::iterator i = _files.find(type);
        return i != _files.end() ? i->second.get() : NULL;
    }
    
    FileCollection* getLocalFiles() { return getFiles(FileCollection::LOCAL); }
    FileCollection* getRemoteFiles() { return getFiles(FileCollection::REMOTE); }

    
    void addSupportedFileType(const std::string& file_type) { _supportedFileTypes.insert(file_type); }
    void addLocalFilePath(const std::string& path);
    
    void setReadFileCompleteHandler(ReadFileCompleteHandler* handler) { _readFileCompleteHandler = handler; }
    
    void applySceneData();

    void readFile(const std::string& file);

protected:
    
private:
    void readFinished(bool success, osg::Node* node, const std::string& file_name);
    bool fileTypeSupported(const std::string& file_extension);
    
    FilesMap _files;
    SupportedFileTypesSet _supportedFileTypes;
    
    osg::ref_ptr<ReadFileThread> _readFileThread;
    osg::ref_ptr<ReadFileCompleteHandler> _readFileCompleteHandler;
    osg::ref_ptr<osg::Node> _sceneNode;
    
    friend class LocalFileCollection;
    friend class RemoteFileCollection;
    friend class ReadFileThread;
};