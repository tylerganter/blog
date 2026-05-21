---
title: "The Promise and Reality of AI Coding: A Short Story"
date: 2026-05-18
tags: [ai, engineering]
description: "Reflections from four months of heavy use of agentic coding tools"
---

Congratulations!!! You got the promotion! The company has been exploring a new type of machine that designs and builds the product automatically. This used to be _your_ job, and instead of getting laid off you got promoted to foreman, whew!

These machines are impressive. You've seen the demos and they manufacture incredibly complicated stuff at blazing speeds. And everyone is talking about them. The testimonials are flooding in about doubling, no tripling, no 10X-ing throughputs!!! You'd be crazy not to have them!

And your promotion is incredibly exciting. There is so much fun learning to do. These new machines are fascinating and you get to work with them day in and day out, tweaking and customizing, iterating until they are fully integrated into your factory in a giant beautifully orchestrated dance. Let's get started!

---

Well...a few months have passed now. The initial excitement of learning has faded. Now it's time to deliver, and the new position isn't exactly what you had hoped. The main problem is that the machines drop bolts on the ground while they operate. This in itself isn't crazy. You occasionally dropped bolts while you worked as well. The problem is that they drop bolts _constantly_ — all day every day. And it's exacerbated by having eight of these machines, each running a conveyor belt much faster than you ever did. You spend a significant fraction of your day on the floor running from station to station with a bucket.

The outputs also don't hold up under scrutiny — they demo'd well, but they're not meeting your quality standards. For a little while you tweaked the machine settings to try to reduce the QA failures. You even installed another conveyor belt that helps with QA and repair, but nothing really cut it. You could continue to tweak and add machines to the line but it's brittle, time-consuming, and not likely to scale: fixing one issue often leads to another resurfacing. You do a lot of manual QA now, but really your main strategy is to manually walk the product from the end of the QA-repair line to the start a few times until it meets some hand-wavey criteria for "good enough".

You contemplate a mitigation: you could slow down the conveyor belts. You quickly brush it off as absurd. Everyone in industry has these machines running at maximum speed. Your competitors certainly do. Management is inundated with stories of how every other company is pulling off impossible feats on a shoestring budget. Besides, you've come to observe an internal pressure. You used to take an entire day to configure your workbench. Now you get impatient if just one of your conveyor belts gets jammed for a few minutes.

And boy do they get jammed! The conveyor belt's manufacturer keeps shipping firmware updates that change the timing. The lighting flickers because the electrical contractor is still iterating. The bolts themselves come from a supplier who occasionally changes the thread pitch without telling anyone. And because you're already running between eight machines, you don't have the slack to absorb it gracefully — every upstream hiccup lands on a day that was already full of bolt-picking.

Production throughput is sky high and quality assurance has gone by the wayside. This inevitably leads to customer complaints. To keep up with the volume, you install another machine that repairs returned defects, but you have found that that machine is also _constantly dropping bolts_.

This is when it really sinks in. You're busier than ever and the work is _less_ interesting than it was when you did it yourself, because the machines are good enough to keep moving but not good enough to be left alone for five minutes. The control room remains unoccupied while you race around the floor.

The work you want to do — the creative, architectural, "what should this system actually be" work — requires sustained attention and stable ground. You can't think hard about a design problem when you're context-switching between a jammed sorting chute, a blown fuse and twelve bins of rejected parts. The tools that promise to free you up to think more are, in practice, fragmenting your attention so thoroughly that the thinking itself gets harder. The hours add up to "productive" on some metric, but the texture of the day is grunt labor and interruption, not creation.

You're not the foreman. You're a very expensive janitor at a factory that ships impressive volume because no one's measuring the defect rate carefully, and the building itself is under active renovation by contractors who don't coordinate with each other. The job pays well. The job is not what it was sold as. And the worst part is that the version where it _is_ what it was sold as feels tantalizingly close — one or two reliability notches away — which makes the current state harder to accept, not easier.

---

## The Trough of Disillusionment

The honeymoon phase is over. For me, it was frenetic, and from what I have seen I was not alone. And I see myself now transitioning to a new phase where unfortunately my primary sentiments are burnout towards AI and jadedness towards most of those who promote it.

### The Promise of AI Coding VS the Reality

The above story is a dramatization. I hope that most agentic coders are not in _that_ bad of a situation. But there is no doubt in my mind that AI is amplifying some of the worst parts of the job, such as

- **hallucinations**: fixing stupid mistakes with no personal growth or satisfaction
- **code reviews**: everyone's favorite
- **bug fixes**: probably mid-sprint, customer-identified issues (assuming your company actually cares about them)

I find that it ebbs and flows, and I never know what my day is going to look like when I flip open my laptop, but here's a list of the bolts I picked up in _one afternoon_:

- prompting me for approval to _read_ a slack message, a permission I set to auto-allow and forgot months ago
- github MCP was "broken" but it actually wasn't, just went away on its own
- claude code appears to have changed so that using skills now requires approval?
  - when requested to investigate the above change in behavior, it just hallucinated unfounded nonsense
- when claude failed to access a doc from the provided link, it simply read a google drive doc instead and lied about it, pretending it was reading the linked doc
- a monitoring service I use modified its interface, distracting me while I was trying to chase down an issue
  - adding insult to injury, on further inspection I realized and later confirmed that there was a misleading bug shipped with the new interface
- cmd+click no longer working in ghostty with claude code on hyperlinks, then it just works again???
- "You're right to push back — I was sloppy in my last response. Let me..."
- "I need to flag a problem. The subagent went off-script: instead of just researching prior PR comments, it ran the entire review pipeline itself and posted a code-review comment on the PR as you (via your gh credentials)"
- wholesale skipping instructions from a two step request
- Opus 4.7 went down
- deleting all the comments in the code
- In words, said that `""` in python is not falsey

Like I said, every day is a new adventure. But it may be helpful to ask yourself: how often are you on the floor picking up bolts?

### The Skill Build-out Delusion

I can picture someone reading the above experience and thinking "have you tried building skills?". The idea that you can write a bunch of markdown files and somehow arrive at general intelligence is delusional, plain and simple. If the AI cannot reliably follow two back-to-back instructions in a single prompt, what makes you think it would reliably follow coding principles autoloaded into context from a nested `AGENTS.md` file? (assuming that file is up-to-date and doesn't contradict `some/other/RULES.md`)

In my opinion it is far more useful to view skills, prompt hooks, and all the other dynamic context engineering tricks as a souped up version of `IMPORTANT: ...`. They're quirks and hacks that increase the probability that the model will do what you want it to. And that's great! Sometimes, those tricks are just what was needed to cross a threshold of being useful. But with this framing it becomes obvious that this is not a scalable solution. Every skill needs to be maintained and updated...it's unscientific and error prone...and as systems scale issues compound. Prompt engineering works great for [narrow AI](https://www.ibm.com/think/topics/artificial-intelligence-types), but there is an upper limit on reliability and therefore on generalization. If there comes a day that we have a reliable system, it won't need your skill files, it's AGI.

### We Are in Their Hands

We are fundamentally constrained by how good the models are, how they are trained, and what the AI labs are focused on. For example, `gpt-5.4-mini` [benchmarks](https://artificialanalysis.ai/?models=gpt-5-4-mini%2Cgpt-5-4-mini-non-reasoning%2Cgpt-5-4-mini-medium%2Cgpt-5-mini%2Cgpt-5-mini-medium%2Cgpt-5-mini-minimal&intelligence=artificial-analysis-intelligence-index) higher on coding challenges but for all else it is more expensive and worse than `gpt-5-mini`.

It took OpenAI [three years to figure out](https://openai.com/index/why-language-models-hallucinate/) you should train with an "I don't know" option, and they still pointed the finger at some amorphous consortium of benchmark curators instead of at themselves. Since then hallucinations have only gotten worse.

![OpenAI hallucination trends]({{ site.baseurl }}/assets/images/agentic-coding-reflections/openai_hallucination_trends.png)
<em>Hallucination rates across OpenAI's recent model releases — [source](https://artificialanalysis.ai/?models=gpt-5-5-high%2Cgpt-5-5%2Cgpt-4o-2024-08-06%2Cgpt-4o%2Cgpt-5%2Cgpt-5-4%2Cgpt-5-2%2Cgpt-5-1&intelligence=artificial-analysis-intelligence-index&omniscience=omniscience-hallucination-rate)</em>

It seems to me that

1. randomly sampling from a predicted probability distribution just doesn't imitate the judgement that humans have in a reliable way. it's a hack to go from _language model_ to generative AI
2. the AI labs aren't putting much emphasis into this anyway. The RL environments are rewarding correct answers, not correct reasoning, and it shows in how they behave out in the wild.

Regardless, it doesn't appear this problem will be going away anytime soon.

### The Slop-pocalypse

We were warned of the impending SaaS-pocalypse, only to get sidelined by an epidemic of AI slop. Tech debt, distractions, upstream issues...none of this is new to software engineering, but the scale is. Github goes down. The AI API goes down. Some other service has an outage. There is a major security vulnerability in a package. There is a security breach and you have to rotate all your keys. And bug after bug after bug. Claude code doesn't display properly in my terminal and I've just shrugged it off despite it being my main interface all day. cURL had to [end their bug bounty program](https://www.bugcrowd.com/blog/hacker-opinion-piece-how-lazy-hacking-killed-curls-bug-bounty/) because "_the security team was drowning in garbage reports_"!!!

This is the answer to what happens when AI slop proliferates through the entire white collar workforce.

### Hypesters

I'm particularly jaded towards the hypesters. I'm talking about the people that say with a straight face that coders are [20x more productive](https://x.com/TFTC21/status/2056815935705714945). I had to tune out months ago from the AI daily brief after claims that [AGI is already here](https://podcasts.apple.com/us/podcast/code-agi-is-functional-agi-and-its-here/id1680633614?i=1000745617772), which is a far cry even by his shaky definition of AGI.

My advice: talk about Anthropic. Anthropic, to me, is the most grounded example of a company that is all in on AI, the good, the bad, and the ugly. They are innovating at an incredible speed. They push out products _fast_. But they are also leaving a wake of bugs in their path, bugs for their customers to [deal with](https://github.com/anthropics/claude-code/issues?q=is%3Aissue%20state%3Aclosed%20archived%3Afalse%20reason%3Anot-planned). Bugs aside, the changes are happening so fast they leave [a bitter experience](https://tylerganter.com/blog/2026/04/02/hi-claude-code-i-think-its-time-we-take-a-break/) with their customers. And let's not forget when they leaked their source code... To be clear I'm not saying their playbook is "wrong". Imperfect, but there are tradeoffs and a lot of uncertainty. I just don't want to hear about how fast you vibe coded your project until it has been [in customer hands for an extended period of time](https://simonwillison.net/2026/May/6/vibe-coding-and-agentic-engineering/#the-new-challenge-of-evaluating-software).

### Centaurs and Reverse-Centaurs

Cory Doctorow has been on one with his criticisms of tech, and [his diagnosis of **reverse centaurs**](https://doctorow.medium.com/https-pluralistic-net-2025-12-05-pop-that-bubble-u-washington-8b6b75abc28e) is on the money:

> In automation theory, a “centaur” is a person who is assisted by a machine. You’re a human head being carried around on a tireless robot body. Driving a car makes you a centaur, and so does using autocomplete.
>
> And obviously, a reverse centaur is machine head on a human body, a person who is serving as a squishy meat appendage for an uncaring machine.

Performing drag and drop because the AI cannot access media through the API...manually reviewing commands because they are operating on sensitive data...cancelling the query and telling the AI "it took too long, optimize it"...these are all examples of the agentic coding reverse centaur. If you've fallen prey to [**cognitive surrender**](https://addyosmani.com/blog/cognitive-surrender/) — the moment an AI reviewer's verdict quietly replaces your own — then the AI is likely in the driver's seat. You are a squishy meat appendage.

I had a laugh reading this comment on [a video](https://www.youtube.com/watch?v=ZugX7a99dLk&lc=UgzSmNahqzRCPc95-H54AaABAg) the other day:

> Dev = 1 hour to code
> LLM = 5 minutes to code
> 5 hours to create the skills for the agent
> 5 hours to review the code
> 1 day to fix all the bugs
>
> PROGRESS !!!

But my takeaway isn't that it's less efficient — it's that there is a real cost beyond just productivity. Is it better for a company to observe 50% productivity gains and all the devs dread waking up in the morning, or 20% gains and happy devs? Heck, make it even more extreme, call it 100% vs 10%, and forget about the well-being of the devs, only the success of the company. The latter still seems like the safer long-term bet.

In case this section wasn't unsettling enough I'll end with [this](https://x.com/damianplayer/status/2056352308347232494). (yes it's real)

---

## Glimmers of Optimism

### AI is Still Pretty Amazing (for Some Things)

There has been a lot of criticism of AI in this post but that doesn't mean it's all bad. I still love leveraging AI for things it is good at, things like

- searching through huge swaths of data for needles
- prototyping
- one-off scripting
- acting as my personal fuzzy dictionary for all established coding patterns and tricks

And AI is **sparking creativity**. This entire blog exists because I had so many thoughts and I wanted to start sharing them. I was able to vibe code the blog without touching the code. I thought it would be nice to add analytics. That took 20 minutes, and AI walked me through it step by step. AI is challenging us to introspect, and some people are creating [truly impressive work](https://www.youtube.com/watch?v=k51k2AyUpao) through that process.

### We Can Be Intentional

The optimist in me says that much of the struggle happening right now is because we aren't being intentional. How could we be? It's all so new. But the patterns are emerging. Even writing this post has helped me solidify them. And if we are unintentionally falling into despair, that means we can _intentionally_ climb to fulfillment.

We have fallen victim to a temptation that AI will make us jacks of all trades, but using AI this way has implications beyond just your effectiveness. It could cause issues across the board if you are taking on work outside of your expertise: pumping out slop, causing bugs, becoming a miserable human appendage for the AI. The solution is to resist this urge; **have clear ownership**, so that contributors can have **pride** in what they are putting out, and be opinionated about doing things the "right" way and not just the way that gets it out the door fastest.

Judgement on when and how it is appropriate to use AI is going to come down to personal taste. I prefer to move slow, do it once and do it right, but the judgement may be different for someone who likes to move fast and loose.

I also think it is now important to note that **agentic coding is not AI engineering**: I have no loyalty to agentic coding. I like math and programming. That's how I got into digital signal processing, then machine learning. As the use of AI tooling for software development branches off and diverges I am hopeful that there will be opportunity to go back to some of the core skills that make an effective AI engineer, namely data-driven experimentation, continuous improvement, and optimizing cost, accuracy, reliability, and speed in an ever-evolving landscape.

### This is a Moment

It hit like a freight train; there is no reason to expect it to remain stable now. For me, Fall 2025 was the heyday. Cursor was at its prime. February was exciting in a different way, so much hustle and bustle and learning. This is a moment. Who knows what the next 6 months will bring. Things could change as quickly as they swept in. So let's enjoy it for what it is. 🙂

<blockquote class="twitter-tweet" data-media-max-width="560"><p lang="en" dir="ltr">This is the greatest video I’ve ever seen. No notes. The lifeless clanker carcass just laying there. No crowd reaction, anything. Just Billie Jean. Until its lifeless shell is shamefully dragged off. Purely amazing. <a href="https://t.co/4WSUwZr7nO">pic.twitter.com/4WSUwZr7nO</a></p>&mdash; Tatum Turn Up (@tatumturnup) <a href="https://twitter.com/tatumturnup/status/2056890084822290719?ref_src=twsrc%5Etfw">May 20, 2026</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

---

_A note on tone: this piece is not a reflection on my company. It draws on my broader experience with AI, the current tenor of public discourse, and a tasteful amount of dramatization. If I thought this were an issue specific to my company, I would be raising it internally or updating my resume. I believe it is an issue with our entire industry, which is why I am sharing these thoughts publicly._
