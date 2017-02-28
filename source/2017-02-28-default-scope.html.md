---
title: Rails and default_scope
published: true
---

It should be common knowledge by now NOT to use default_scope unless you know what you're doing. I *thought* I knew what I was doing
but was wrong, which is often the case.

Imagine having a model with a boolean :finished attribute. And in your schema for this table  default: false.
You want to only ever retrieve instances that are marked finished, so you write

    default_scope {where(finished: true)}

Great, but guess what? New instances of this model will have their :finished default to true, contrary to the schema definition.
Crazy right? Don't use default_scope.

