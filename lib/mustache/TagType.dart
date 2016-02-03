/*
 * Copyright (c) 2016, Michael Mitterer (office@mikemitterer.at),
 * IT-Consulting and Development Limited.
 * 
 * All Rights Reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of mdlmustache;

class Tag {
    Tag(this.type, this.name, this.start, this.end);

    final TagType type;
    final String name;
    final int start;
    final int end;
}

class TagType {
    const TagType(this.name);

    final String name;

    static const TagType openSection = const TagType('openSection');
    static const TagType openInverseSection = const TagType('openInverseSection');
    static const TagType closeSection = const TagType('closeSection');


    /// The most basic tag type is the variable. A <code>{{name}}</code> tag in a basic template will
    /// try to find the name key in the current context.
    static const TagType variable = const TagType('variable');

    static const TagType tripleMustache = const TagType('tripleMustache');
    static const TagType unescapedVariable = const TagType('unescapedVariable');
    static const TagType partial = const TagType('partial');
    static const TagType comment = const TagType('comment');
    static const TagType changeDelimiter = const TagType('changeDelimiter');
}