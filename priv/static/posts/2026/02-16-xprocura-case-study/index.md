%{
  title: "XProcura Case Study",
  author: "Brian Hammer",
  tags: ~w(case-study),
  description: "Realtime construction management software.",
  image_url: "/posts/2026/02-16-xprocura-case-study/shipments-overview-screenshot.png",
  read_time: 15,
  hidden?: false
}
---

## Real-time construction procurement tracking

XProcura is a B2B SaaS startup in the construction industry that helps general contractors track shipments. The SaaS solves the issue of construction managers constantly calling subcontractors to verify shipments are on time. The solution involves a multi-tenant multi-project system where subcontractors can only view items related to their trade. 


![Project Homepage](/posts/2026/02-16-xprocura-case-study/project-homepage-screenshot.png)

### The Business Problem

XProcura helps construction managers, known as general contractors, verify their shipments are on time. The current procurement tracking process is time consuming and requires numerous phone calls just to verify an item is on-time.

XProcura aims to save general contractors hours of phone calls by having a platform to confirm shipments and deliveries. It also gives the general contractor more with audit logs, a calendar of upcoming deliveries, limiting user access, and notifications when confirmations are due.

![Division Overview](/posts/2026/02-16-xprocura-case-study/divisions-overview-screenshot.png)


### Technical Challenges

The solution involves a **highly complex app.** It requires a multi-tenant app where many users will have restricted access. Furthermore, it also needs a confirmation and status system for each of its shipments, as well as a notification system when an item is due. It also requires an audit log of who took what action. Charts and calendars are also required for upper-management to see an overview of what is happening on a project. 

The founder attempted to get this built twice before LiveLogic, and both failed due to the high technical complexity. 

![Item Shipments](/posts/2026/02-16-xprocura-case-study/item-shipments-screenshot.png)


### Our Approach - Elixir and Phoenix

We chose to build this app in a functional programming language known as Elixir. Functional Programming is a special programming paradigm excellent at handling complex logic and delivering on repeatable results, meaning fewer unexpected errors. Furthermore, Elixir is known to scale extremely easily, setting XProcura up on solid foundations as it gains users.

On top of Elixir, we used Phoenix and LiveView as the tech stack. This is a full-stack framework known for simplifiying server-side logic while being real-time - saving from feature creep and deadline explosions. This tech stack decision paid off tremendously as we worked, and will pay off even more as the business scales.

#### Designing the Product

Designing the software involved handling multi tenant projects and invites, items having multiple deliveries per item, and seeing which deliveries are due for confirmation. We ended up making separate pages in each project for user management, shipment confirmations, and item/shipment creation, as well as other pages for the calendar and graph overview. 

![Project Homepage](/posts/2026/02-16-xprocura-case-study/item-shipments-screenshot.png)

###### Invite System

We designed an invite system that is easy to onboard both users with or without accounts, increasing user satisfaction with the software. A subcontractor gets an email, and an invite automatically connected to the account when a general contractor invites them. An invite will automatically be created once the user signs up with their confirmed email. This email-first solution allows general contractors to easily add and onboard new users without the headache of managing usernames.


###### Shipment Confirmations

The shipments page condenses lots of information such as shipping status, delivery/shipping date, on time and delayed info, and "confirmation due notification" in a way that is simple and intuitive for the users. The shipment status is entirely derived from the shipment confirmation which gives the general contractor accurate and reliable information. 

![Shipment Overview](/posts/2026/02-16-xprocura-case-study/shipments-overview-screenshot.png)


## Conclusion

Although XProcura struggled to get the project built at first, they are now **set up for success with LiveLogic!** The founder reports great reviews among general contractors saying this software is highly needed. His innovative idea is now a reality with an easy invite system, an intuitive yet complex shipments system, and reliable code that's easily scale as demand increases. [Will you be the next founder?](/#contact-us)

XProcura will soon start testing with [moss.com](https://www.moss.com) - a **multi-billion dollar** construction contractor.

[Xprocura's Website](https://www.xprocura.com)